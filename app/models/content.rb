require 'nokogiri'
require 'open-uri'
class Content

	def self.get_urls
		links = []
		contents = []
		doc = Nokogiri::HTML(open('http://blog.sina.com.cn/s/articlelist_1876727874_2_1.html'))

		# 获取页面上所有的链接
		doc.css('span.atc_title a').each do |link|
			p link.content
		  contents << link.content
		  links << link['href']
		end

		doc = Nokogiri::HTML(open('http://blog.sina.com.cn/s/articlelist_1876727874_2_2.html'))
		# 获取页面上所有的链接
		doc.css('span.atc_title a').each do |link|
			p link.content
		  contents << link.content
		  links << link['href']
		end
		return contents.reverse!, links.reverse!
	end

	# Content.get_contents
	def self.get_contents
		contents, links = get_urls()
		links.each_with_index do |link, i|
			p "page #{i} ============="
			p link
			doc = Nokogiri::HTML(open(link))
			body = body_head
			if i == 0
				body.gsub!("{{unit}}", "單元#{i + 1}")
			else
				body.gsub!("{{unit}}", "單元#{i + 1}")
			end
			body.gsub!("{{title}}", "單元#{contents[i]}")
			ct = doc.at("div.articalContent").inner_html
			if ct.present?
				body << ct
				body << body_foot
				File.open("#{Rails.root}/files/app1/#{i}.html", "wb+") do |f|
					f.write body
				end
			else
				p "content is blank ++++++++++++++"
			end
			return "links: #{links.size}"
		end
		
	end

	def self.body_head
		body =<<EOF
<!DOCTYPE html> 
<html>
<head>
    <title>{{unit}}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="css/vendor/jquery.mobile-1.4.3.min.css" />
    <script src="js/vendor/jquery-1.11.1.min.js"></script>
    <script src="js/vendor/jquery.mobile-1.4.3.min.js"></script>
</head>

<body>
<div data-role="page">
    <div data-role="header" data-position="fixed">
        <h1>{{title}}</h1>
        <a href="#"  data-icon="back" data-rel="back">Back</a>
    </div><!-- /header -->
    <div role="main" class="ui-content">
EOF
	end

	def self.body_foot
		body =<<EOF
			</div><!-- /content -->
    <div data-role="footer">
        <h4></h4>
    </div>
</div>
</body>
</html>  
EOF
	end

end