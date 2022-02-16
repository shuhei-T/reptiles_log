module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
      'Reptiles_log(管理画面)'
    else
      'Reptiles_log'
    end
    
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def active_header(path)
    path == action_name ? 'active' : ''
  end

  def active_footer(controller_name, action_path)
      if controller_path == controller_name && action_path == action_name
        'active'
      else
        ''
      end
  end
end
