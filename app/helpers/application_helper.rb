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
      title: '爬虫類飼育者のためのかんたん飼育記録サービス',
      reverse: true,
      charset: 'utf-8',
      keywords: '爬虫類,蛇,飼育,ヒョウモントカゲモドキ',
      separator: '|',
      connonical: 'request.original_url',
      description: '爬虫類のための飼育記録アプリならレプログ!。爬虫類は他のペットと違う特性をもつ生き物なので、特徴をうまく汲み取って飼育管理を行う必要があります。爬虫類飼育者の悩みを解消し、かんたんにお世話記録をすることができるサービスです。',
      og: default_og,
      twitter: default_twitter_card
    }
  end

  private

  def default_og
    {
      title: :full_title,
      description: :description,
      type: 'website',
      url: request.original_url,
      image: image_url('replog_ogp.png'),
      locale: 'ja_JP'
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image',
      site: '@reptileslog'
    }
  end
end
