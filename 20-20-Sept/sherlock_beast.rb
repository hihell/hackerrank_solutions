
def cal(num)
	db5 = 0
	db3 = num
	while(db3 >= 0)
		if(db3 / 3 * 3 == db3)
			return db3
		end
		db5 += 5
		db3 = num - db5
	end
	return -1
end

def main()
	n = gets.chomp.to_i
	res = Array.new
	req = Array.new
	n.times do
		num = gets.chomp.to_i
		r = cal(num)
		res.push(r)
		req.push(num)
	end
		
	res.each_with_index do |e, i|
		dgs5 = e 
		if(dgs5 != -1)
			dgs5.times do
				print 5
			end
			(req[i] - dgs5).times do
				print 3
			end
			print "\n"
		else
			puts -1
		end
	end
end

main()	
