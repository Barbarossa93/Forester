#!/usr/bin/env python3
# opentype-bitmap - generate opentype bitmap (.otb) from BDF/PCF fonts

# NOTE
# Greater than version 20190413 is needed.  Otherwise ensure your fontforge
# has commit 79f9e0b8442631ac39ab907af20b813ac584298f

import argparse
import fontforge
import gzip
import os.path
import sys

from tempfile import NamedTemporaryFile


def import_bitmap(font, filename):
    if filename.endswith('.pcf.gz') or filename.endswith('.bdf.gz'):
        ext = filename[-7:-3]  # .pcf or .bdf

        with gzip.open(filename) as gz, NamedTemporaryFile(suffix=ext) as temp:
            temp.write(gz.read())
            font.importBitmaps(temp.name)

    elif filename.endswith('.pcf') or filename.endswith('.bdf'):
        font.importBitmaps(filename)

    else:
        raise ValueError('Unknown extension')


def generate(fontname, files):
    filename = fontname + '.otb'
    newfont = fontforge.font()

    for file in files:
        if args.verbose:
            print(f'{filename}: {file}: importing bitmap strikes',
                  file=sys.stderr)

        try:
            import_bitmap(newfont, file)

        except ValueError:
            print(f'opentype-bitmap: warning: {file}: file must end with '
                  '.pcf.gz, bdf.gz, .pcf, or .bdf', file=sys.stderr)

        except OSError:
            print(f'opentype-bitmap: warning: {file}: invalid bitmap font',
                  file=sys.stderr)

    if newfont.changed:
        newfont.generate(filename, 'otb')
        print(f'{filename}')


parser = argparse.ArgumentParser(add_help=False)
parser.add_argument('-v', dest='verbose', action='store_true')
parser.add_argument('files', nargs='*')
args = parser.parse_args()

if not args.files:
    args.files = (line.rstrip('\n') for line in sys.stdin)

fontfiles = {}

for file in args.files:
    if os.path.isfile(file):

        # Opening the file here to extract the fontname.  There may be a better
        # way to do this.

        # fontforge.open doesn't provide __enter__ and __exit__ attributes.
        f = fontforge.open(file)

        fontfiles.setdefault(f.fontname, []).append(file)
        f.close()

    else:
        print(f'opentype-bitmap: warning: {line}: no such file',
              file=sys.stderr)

for fontname in fontfiles:
    generate(fontname, fontfiles[fontname])
