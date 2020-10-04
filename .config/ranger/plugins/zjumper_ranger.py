import ranger.api
import subprocess
from ranger.api.commands import *


class z(Command):
    """:z
    Uses z to set the current directory.
    """
    def execute(self):

        # return directories satisfying the querry
        #  ~/.z file to be present in home, if file in different location change the below command at the end
        cmd = """awk -F "|" -v q=\""""+" ".join(self.args[1:])+"""\" 'BEGIN{gsub(/ /, ".*", q)}  { if(tolower($1) ~ q){ print $1} }'  ~/.z"""


        directories,error = subprocess.Popen(cmd, shell=True, executable="/bin/bash", stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
        directories = directories.decode("utf-8", "ignore")
        directories = directories.rstrip('\n').split("\n")

        #  smallest directory will be the directory required
        self.fm.execute_console("cd " + min(directories))
