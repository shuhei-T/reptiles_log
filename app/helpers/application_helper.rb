module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
      'レプログ!(管理画面)'
    else
      'レプログ!'
    end
    
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def active_header(path)
    path == action_name ? 'active' : ''
  end


  def active_if(controller_name, action_path)
      if controller_path == controller_name && action_path == action_name
        'active'
      else
        ''
      end
  end

  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def default_meta_tags
    {
      site: 'レプログ!',
      title: 'タイトル',
      reverse: true,
      separator: '|',
      og: default_og,
      twitter: default_twitter_card
    }
  end

  private

  def default_og
    {
      title: :full_title,
      description: :description,
      url: request.url,
      image: image_url('replog_ogp.png')
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image',
      site: '@reptileslog'
    }
  end
end
