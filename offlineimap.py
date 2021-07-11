# don't forget to install secret-tool
import subprocess
def get_password(host, username):
  return subprocess.check_output([
      "secret-tool",
      "lookup",
      "service",
      "smtp",
      "host",
      host,
      "user",
      username])

def get_custom(host, username, cred_type):
  ret= subprocess.check_output([
      "secret-tool",
      "lookup",
      "service",
      "smtp",
      "host",
      host,
      "user",
      username,
      "type",
      cred_type]).splitlines()[0]
  return ret.decode()
