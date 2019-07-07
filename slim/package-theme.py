#!/run/current-system/sw/bin/python3

import os
import tarfile
import hashlib

THEME_DIRECTORY = "theme"
THEME_PACKAGE_NAME = "slim-theme.tar.gz"
CHEKSUM_BUFFER_SIZE = 65536 # 64kb

def clean_up():
    try:
        os.remove(THEME_PACKAGE_NAME)
    except OSError as e:
        print ("File %s doesn't exist" % e.filename)

def package_theme():
    tar = tarfile.open(THEME_PACKAGE_NAME, "w:gz")
    tar.add(THEME_DIRECTORY, arcname=THEME_DIRECTORY)
    tar.close()

def print_sha256():
    sha256 = hashlib.sha256()

    with open(THEME_PACKAGE_NAME, 'rb') as f:
        while True:
            data = f.read(CHEKSUM_BUFFER_SIZE)
            if not data:
                break
            sha256.update(data)

    print("sha256: {0}".format(sha256.hexdigest()))

clean_up()
package_theme()
print_sha256()