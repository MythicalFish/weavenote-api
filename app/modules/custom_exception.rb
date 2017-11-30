module CustomException
  class UserError < StandardError; end
  class UserWarning < StandardError; end
  class PermissionError < StandardError; end
  class Redirect < StandardError; end
end