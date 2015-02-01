class Content

	def self.get_urls
		uri = URI("http://blog.sina.com.cn/s/articlelist_1876727874_0_1.html")
		res = Net::HTTP.get_response(uri)
		html = res.body

		# p page
		# reg =  /\s*(?i)href\s*=\s*(\"([^"]*\")|'[^']*'|([^'">\s]+))/
		# # # reg = /atc_title/
		# # arr = page.split("\r\n")
		# # arr.size
		# # page.split("\r\n").each do |s|
		# # 	arr = reg.match(s)
		# # 	p arr.to_a.last
		# # end
		# arr = reg.match(html)
		# # p arr
		# arr.to_a.each do |h|
		# 	p h
		# end


		end_chars = %q(.,'?!:;)
		arr = URI.extract(html, ['http']).collect { |u| end_chars.index(u[-1]) ? u.chop : u }
		arr = arr.select do |u|
			u =~ /.*blog\_.+.html$/
		end
		p arr
	end

	def self.get_contents
	end

end