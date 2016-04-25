import marshal
import os
import re
import pipes
import subprocess
import tempfile
import vim

def sanitize(path):
  # Perforce will output Windows-style paths sometimes; if the backslashes in such
  # paths are not escaped when transmitting them to the vim API, they will be parsed
  # as escape codes and result in mangled output.
  return re.sub(r"\\", r"\\\\", path).strip()


def printNote(message):
  vim.command("echo \"{0}\"".format(sanitize(message)))


def printError(message):
  vim.command("echohl ErrorMsg | echo \"{0}\" | echohl None".format(sanitize(message)))


def execute(*args):
  command = ["p4", "-G"]
  command.extend(args)

  command = ["/bin/sh", "-c"] + [" ".join(map(pipes.quote, command))]

  # marshal.load will not accept file-like objects, only true files.
  with tempfile.TemporaryFile() as temporary:
    process = subprocess.Popen(command, shell=False, stdin=subprocess.PIPE, stdout=temporary, stderr=subprocess.PIPE)
    process.communicate()

    results = []
    temporary.seek(0)
    try:
      while 1:
        results.append(marshal.load(temporary.file))
    except EOFError:
      pass

  return results


def paveOpen(path):
  result = execute("edit", path)[0]
  if result["code"] == "error" and re.search("not on client", result["data"]):
    result = execute("add", path)[0]
  if result["code"] != "stat":
    printError(result["data"])
  else:
    printNote("Perforce: opened {0}".format(result["depotFile"]))
    vim.command("setlocal noreadonly")


def paveRevert(path):
  result = execute("revert", path)[0]
  if result["code"] != "stat":
    printError(result["data"])
  else:
    printNote("Perforce: reverted {0}".format(result["depotFile"]))
    vim.command("edit!")
    vim.command("setlocal readonly")

def paveDiff(path):
  extension = os.path.splitext(path)[1]
  result = execute("print", path)
  temp = tempfile.NamedTemporaryFile(delete=False, suffix=extension)
  for chunk in result[1:]:
    temp.write(chunk["data"])
  temp.flush()

  vim.command("vertical diffsplit {0}".format(temp.name))
