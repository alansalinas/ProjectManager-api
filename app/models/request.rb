class Request < ActiveRecord::Base
  
  def status(JsonObject)
    p JsonObject
    return JsonObject.status
  end
  
  def code(JsonObject)
    p JsonObject
    return JsonObject.code
  end
  
end
