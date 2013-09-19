require 'benchmark'

def cal_short(string, energy, energy_map)
#	puts string
	h = Hash.new
	a = energy_map
	mid = -1
	ce = 0
	if(!energy_map) # if we don't have energy map, make it!
		a = Array.new
		string.chars.each_with_index do |e, i|	
			if(e == '0')
				ce -= 2
			elsif(e == '1')
				ce += 3
			elsif(e == '2')
				ce += energy
				mid = i
			end 	

			h[ce] = i
			a[i] = ce
		end
	end

	max_len = 0
	string.chars.each_with_index do |e, i|
		max_0 = max_1 = 0
		lv = 0 
		if(e == '0')
			lv = a[i] + 2			
		elsif(e == '1')
			lv = a[i] - 3
		elsif(e == '2')
			lv = a[i] - energy
		end
		max_0 = h[lv] != nil ? h[lv] : i
		max_1 = h[lv + 1] != nil ? h[lv + 1] : i

		max01 = [max_0, max_1].max
		max01 = a.last >= lv ? a.length - 1 : max01	
		if(max01 >= mid)

			max_len = max_len > max01 - i + 1 ? max_len : max01 - i + 1
			
			if(string[max01] == '0' and max_len == 1)
				max_len = 0
			end
		end	
	
		if(i == mid)
			break
		end
	end
	
	return max_len
end


def cal()
	
	k, s = gets.chomp.split(' ')
	k = k.to_i	
	
	if(k > 2)
		crt = 0
		la = Array.new
		s.chars.each do |e|
			crt += e == '0' ? -2 : 3
			la.push(crt)
		end
		e = crt
		
		crt = 0
		ra = Array.new
		s.chars.reverse_each do |e|
			crt += e == '0' ? -2 : 3
			ra.push(crt)
		end

		lm = la.each_with_index.max
		rm = ra.each_with_index.max
		
		totalE = 0
		totalL = 0
		remainL = s
		remainR = s
		if(lm[0] > 0)
			totalE += lm[0]
			totalL += lm[1] + 1
			remainR = s.slice(lm[1] + 1, s.length)
		end
		if(rm[0] > 0)
			totalE += rm[0]
			totalL += rm[1] + 1
			remainL = s.slice(0, s.length - rm[1] - 1)
		end

		if(e >= 0)
			return k * s.length
		elsif(totalE + e >= 0)
			num = (totalE / e.abs) < (k - 2) ? (totalE / e.abs) : (k - 2)
			 
			len = num * s.length + totalL
			
			remain = totalE + num * e
			
			if(remain > 0)		
				# use the remaining energy to make it longer
				rest = remainL + '2' + remainR
				# the short array passed to function contains 1 pseudo char
				# remove that from the length 
				len += cal_short(rest, remain, nil) - 1
			end
			return len 
		else
			if(k >= 2)
				return cal_short(s+s, 0, nil)
			else
				return cal_short(s, 0, la)
			end
		end

	else
		ss = String.new
		k.times do
			ss += s
		end
		
		return cal_short(ss, 0, nil)
	end

end

def main()
	# Benchmark.bm do |b|
		# b.report {
			puts cal()
		# }
	# end
end

main()
