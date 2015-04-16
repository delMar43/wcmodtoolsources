#accept an array of bytes, an offset in that array, and how many bytes starting at that offset to convert to the opposite endian
def conv_endian(bytes, offset, numbytes):

	sum = 0
	for n in range(0,numbytes):
		if offset+n < len(bytes):
			sum += bytes[offset+n]*(256**n)
		else:
			sum = -1

	return sum
	
#accepts a number to convert to two's compliment, in the accepted number of bits
def conv_twos(number, bits):
	if number >= 2**(bits-1):
		return number - 2**bits
	else:
		return number


#needs to recognize when there's a secondary table and when there's not
def readfile(filename, datas = []):

	blocks = []

	fp = open(filename, 'rb')
	string = fp.read()
	fp.close()

	bytes = [ord(s) for s in string]
	
	#read file length
	filelen = conv_endian(bytes, 0, 4)
	#ADD CHECK FOR FILE LENGTH COMPARED TO WHAT SYSTEM REPORTS

	#read first table, make list of secondary tables
	endtable1 = conv_endian(bytes, 4, 3)
	
	table1 = []
	for offset in range(4, endtable1, 4):
		table1.append(conv_endian(bytes, offset, 3))
	
	#for each entry in the primary table (pointer to a block, either data or a secondary table)
	for j in range (0, len(table1)):
		offset = table1[j]
		endtable = conv_endian(bytes, offset, 4)
		
		#read where the table ends (assuming it's a table)
		if j+1 < len(table1):
			endblock= table1[j+1]
		else:
			endblock = filelen

		table2 = []
		flag = 0
		for i in range(offset, min((offset+endtable, filelen)), 4):
			table2.append(offset + conv_endian(bytes, i, 4))
		
		flag = 0
		
		for i in range(0, len(table2)):
			offset2 = table2[i]
			
			if offset2 > endblock:
				flag += 1
				table2 = table2[:i]
				break
			
		#if flag > 0 or j in datas:
		if j in datas:
			blocks.append(bytes[offset:endblock])
			#print endblock-offset
			
		else:
			blocks.append([])
			for i in range(0, len(table2)):
				offset2 = table2[i]
				if i+1 < len(table2):
					endentry = table2[i+1]
				else:
					endentry = endblock
					#endentry = table2[-1]+500
				
				blocks[-1].append(bytes[offset2:endentry])
			#	print endentry-offset2
			
			#outfile = open(filename + '_' + `j` + '_' + `i` + '.txt', 'w')
			#str = "".join([chr(x) for x in bytes[offset2:endentry]])
			
			#outfile.write(str)
			#outfile.close()
			
	return blocks
			
def writefile(filename, blocks):
	debug = open('debug.txt', 'wb')

	filesize = 4 + len(blocks) * 4
	pri_table = []
	sec_tables = []
	off_count_1 = len(blocks) * 4 + 4
	flags = []
	for b1 in blocks:
		
		if len(b1) > 0 and type(b1[0]) is list:
			filesize += len(b1) * 4
			sec_table = []
			off_count_2 = len(b1) * 4
			for b2 in b1:
				sec_table.append(off_count_2)
				off_count_2 += len(b2)
				filesize += len(b2)
			pri_table.append(off_count_1)
			off_count_1 += off_count_2
			sec_tables.append(sec_table)
			flags.append(0)
		else:
			filesize += len(b1)
			pri_table.append(off_count_1)
			off_count_1 += len(b1)
			sec_tables.append(b1)
			flags.append(1)
	
	bytes = []
	remainder = filesize
	while remainder > 0 or len(bytes) < 4:
		bytes.append(remainder % 256)
		remainder /= 256
	
	for e in pri_table:
		remainder = e
		count = 0
		while remainder > 0 or count < 4:
			bytes.append(remainder % 256)
			remainder /= 256
			count += 1
	
	#sec_tables doesn't contain data blocks, need to be inserted
	for i in range(0, len(sec_tables)):
		t = sec_tables[i]
		
		if flags[i] == 0:
			for j in range(0, len(t)):
				e = t[j]
				remainder = e
				count = 0
				while remainder > 0 or count < 4:
					bytes.append(remainder % 256)
					remainder /= 256
					count += 1
			
			for j in range(0, len(t)):
				if len(blocks[i]) > j:
					if type(blocks[i][j]) is list:
						bytes.extend(blocks[i][j])
					else:
						bytes.append(blocks[i][j])
						
		else:
			bytes.extend(blocks[i])
	
	str = "".join([chr(x) for x in bytes])
	
	debug.close()
	
	fp = open(filename, 'wb')
	fp.write(str)
	fp.close()
			

			
blocks= readfile("camp.002", [0,1,2])

str = ""
print len(blocks[0])
for i in range(0, len(blocks[0]), 8):
	vals = []
	for j in range(0, 8, 2):
		vals.append(blocks[0][i+j] + 256 * blocks[0][i+j+1])
	if vals[0] == 65535:
		#print "BLANK"
		pass
	else:
		#str += `vals`
		pass
	str += `i/32+1` + "-" + `i%32/8+1` + ": " + `vals` + "\n"
		
	if i % 32 == 24:
		str += "\n"
	

f = open("output2.txt", "w")
f.write(str)
f.close()
print str

chunks = []
for i in range(0, len(blocks[1]), 90):
	chunks.append(blocks[1][i:i+90])
	
def add(x,y): return x+y
	
for i in range(0, len(chunks)):
	c = chunks[i]
	for j in range(10, len(c), 20):
		#print `i+1` + '-' + `j/20+1` + ": " + `reduce(add, c[j+4:j+20])`
		pass


	#	print vals
	
writefile("camp.000.tst", blocks)