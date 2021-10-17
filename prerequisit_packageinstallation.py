import subprocess
import os

def is_tool(name):
    try:
        devnull = open(os.devnull)
        subprocess.Popen([name], stdout=devnull, stderr=devnull).communicate()

    except OSError as e:
        print(name,": Package is not installed")
        return True

packages=["eksctl","aws-iam-authenticator","awscli","kubectl"]
for package in packages:

    if is_tool(package) == True:
        subprocess.run(["bash", "Prerequisist_download.sh"])
