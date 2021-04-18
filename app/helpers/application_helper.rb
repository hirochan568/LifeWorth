module ApplicationHelper
  def  create_at_by(instanse)
    instanse.created_at.strftime('%Y/%m/%d')
  end
  
  
end
