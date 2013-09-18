def cal(n, k)
	c2 = (2 * n - 1) / k
	c1 = (n + 1) / k
	count = 0
	if(k.even?)
		count += ((k / 2 - 1) + (c1 * k / 2 - 1)) * c1 / 2
		count += ( 2 * n - (c2 * k / 2) - ((c1 + 1) * k / 2)) * (c2 - c1) / 2
	else
		if(c1.even?)
			count += (k / 2 + (c1 - 1) * k / 2) * (c1 / 2) / 2
			count += (k - 1 + c1 * k / 2 - 1) * (c1 / 2) / 2
		else
			count += (k / 2 + c1 * k / 2) * (c1 / 2 + 1) / 2
			count += (k - 1 + (c1 - 1) * k / 2 - 1) * (c1 / 2) / 2 
		end
		
		if((c2-c1).even?)
			count += (n - ((c1 + 1) * k / 2 + 1) + n - (c2 - 1) * k / 2 + 1) * (c2 - c1) / 2 / 2
			count += (n - ((c1 + 2) * k / 2 + 1) + n - c2 * k / 2 + 1) * (c2 - c1) / 2 / 2
		else
			count += (n - ((c1 + 1) * k / 2 ) + n - c2 * k / 2 ) * ((c2 - c1) / 2 + 1) / 2
			count += (n - ((c1 + 2) * k / 2 ) + n - (c2 - 1) * k / 2) * ((c2 - c1) / 2) / 2
		end
	end
end

def main()
        t = gets.chomp.to_i
        res = Array.new
        t.times do
                n, k = gets.chomp.split(' ').map{|x| x.to_i}
                
		if(n == 1)
			res.push(0)
		elsif(k == 1)
			c = (2 * n - 1) / 2 * ((2 * n - 1) / 2 + 1) / 2
			c += ((2 * n - 1) / 2 - 1) * ((2 * n  - 1) / 2) / 2
			res.push(c)
		else 
			res.push(cal(n, k))
		end
        end
        res.each {|e| puts e}
end

main()
