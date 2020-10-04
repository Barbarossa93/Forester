import subprocess
from ranger.api.commands import Command


class git(Command):

    commands = 'init status clone add rm restore commit remote push'.split()


    def execute(self):
        # empty
        if not self.arg(1):
            return self.fm.notify("For commands check \"git help\"")

        # help
        if self.arg(1) == "help":
            return self.fm.notify("Not done yet!", bad=True)

        # init
        if self.arg(1) == self.commands[0]:
            subprocess.run(["git", "init", "--quiet"])
            return self.fm.notify("Repository initialized successefully")

        # status
        if self.arg(1) == self.commands[1]:
            output = subprocess.check_output(["git", "status"]).decode()

            with open('/tmp/gitplug-status', 'w') as out:
                out.write(output)

            return self.fm.edit_file('/tmp/gitplug-status')

        # clone
        # TIP!
        #       to clone private repositorues you have to store your data
        #       using: "git config --global credential.helper store" in your
        #       terminals emulator(not ranger! it will not work!) and then
        #       do one pull still from terminals emulator and then you can
        #       clone private repositories from ranger.
        if self.arg(1) == self.commands[2]:
            if not self.arg(2):
                return self.fm.notify("Missing url!", bad=True)

            if self.arg(2):
                subprocess.run(["git", "clone", self.arg(2), "--quiet"])
                return self.fm.notify("Repository successfully cloned!")

        # add
        if self.arg(1) == self.commands[3]:
            if not self.arg(2):
                return self.fm.notify("Missing arguments! Usage :git add <file>", bad=True)

            if self.arg(2):
                subprocess.run(["git", "add", self.arg(2)])
                return self.fm.notify("Successfully added files to branch!")

        #rm
        if self.arg(1) == self.commands[4]:
            if not self.arg(2):
                return self.fm.notify("Missing arguments! Usage :git rm <file>", bad=True)

            if self.arg(2):
                subprocess.run(["git", "rm", self.arg(2)])
                return self.fm.notify("Successfully removed files from branch!")

        # restore
        if self.arg(1) == self.commands[5]:
            if not self.arg(2):
                return self.fm.notify("Missing arguments! Usage :git restore <file>", bad=True)

            if self.arg(2):
                subprocess.run(["git", "restore", "--staged", self.arg(2), "--quiet"])
                return self.fm.notify("Successfully restored files!")

        # commit
        if self.arg(1) == self.commands[6]:
            if not self.rest(2):
                return self.fm.notify("Missing commit text", bad=True)

            if self.rest(2):
                subprocess.run(["git", "commit", "-m", self.rest(2), "--quiet"])
                return self.fm.notify("Successfully commited!")
        
        # remote
        if self.arg(1) == self.commands[7]:
            if not self.arg(2):
                return self.fm.notify("Missing arguments! Use: git remote add/rm <name> <url>", bad=True)

            if self.arg(2) == "add":
                if not self.arg(3):
                    return self.fm.notify("Missing name and url!", bad=True)

                if self.arg(3):
                    if not self.arg(4):
                        return self.fm.notify("Missing url!", bad=True)

                    if self.arg(4):
                        subprocess.run(["git", "remote", "add", self.arg(3), self.arg(4)])
                        return self.fm.notify("Remote successfully added!")

            if self.arg(2) == "rm":
                if not self.arg(3):
                    return self.fm.notify("Missing name!", bad=True)

                if self.arg(3):
                    subprocess.run(["git", "remote", "rm", self.arg(3)])
                    return self.fm.notify("Remote successfully removed")

        # push
        if self.arg(1) == self.commands[8]:
            if self.arg(2) == "-u" and self.arg(3) and self.arg(4):
                subprocess.run(["git", "push", "--quiet", "-u", self.arg(3), self.arg(4)])
                return self.fm.notify("Repository successfully pushed")

            if not self.arg(2):
                subprocess.run(["git", "push", "--quiet"])
                return self.fm.notify("Repository successfully pushed")
