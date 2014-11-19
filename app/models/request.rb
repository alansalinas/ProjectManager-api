class Request < ActiveRecord::Base
  
  def status(jsonObject)
    p jsonObject
    return jsonObject.status
  end
  
  def code(jsonObject)
    p jsonObject
    return jsonObject.code
  end
  
  def self.print(a)
    p a
    return 1
  end
  
end
