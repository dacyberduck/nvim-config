local present, impatient = pcall(require,'impatient')
if not present then
  print("Error: impatient not found!!!")
  return 1
end

impatient.enable_profile()
