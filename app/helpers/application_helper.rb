module ApplicationHelper

  def active_menu(active,controller)
  	  active == controller ? 'class="active"' : "empty" 
  end

  def time1(time)
  	return if time.nil?
  	time.strftime("%b-%e-%Y %H:%M")
  end

  def selected_opt(a,b)
  	a == b ? 'selected' : '' 
  end

end
