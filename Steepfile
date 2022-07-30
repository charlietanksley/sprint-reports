D = Steep::Diagnostic

target :lib do
  signature 'sig'

  check 'lib'                       # Directory name
  check 'Gemfile'                   # File name

  configure_code_diagnostics(D::Ruby.strict) # `strict` diagnostics setting
end

# target :test do
#   signature "sig", "sig-private"
#
#   check "test"
#
#   # library "pathname", "set"       # Standard libraries
# end
