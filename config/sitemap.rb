require 'fog-aws'
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.reptileslog.com/"
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-#{ENV['AWS_DEFAULT_REGION']}.amazonaws.com/#{ENV['AWS_S3_BADGET_NAME']}"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
# store on S3 using Fog (pass in configuration values as shown above if needed)
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                      fog_directory: ENV['AWS_S3_BADGET_NAME'],
                                      aws_region: ENV['AWS_DEFAULT_REGION'])

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
    # add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
