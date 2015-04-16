"""
block
	header
		filesize
		table
	bytes
	data
	sub-blocks
"""

def SwapEndian(bytes):
	retval = 0
	for i in range(0, len(bytes)):
		b = bytes[i]
		#retval += b*256**(len(bytes)-1-i)
		retval += b*256**(i)
		
	return retval

class Table:
	def __init__(self, bytes):
		self.bytes = bytes
		self.offsets = []
		self.offsets.append(SwapEndian(bytes[0:3])) #get the first offset in the table, to find the end of the table
		for i in range(4, self.offsets[0]-4, 4): #get the rest of the offsets
			self.offsets.append(SwapEndian(bytes[i:i+3]))
	
class Header:
	def __init__(self, bytes):
		self.bytes = bytes
		self.blocksize = SwapEndian(bytes[0:4])
		
		if (self.blocksize != len(bytes)): #check to see if the block size is legit; otherwise, not a valid block; could be more error checking
			raise ValueError
			
		else:
			self.table = Table(bytes[4:]).offsets
		
class DataBlock:
	def __init__(self, bytes):		
		try:
			self.header = Header(bytes)
		
			self.bytes = bytes
			self.data = self.bytes[self.header.table[0]:] #the data starts at the first table offset
			self.blocks = []
			
			offs = self.header.table
			
			
			for i in range(0, len(offs)): #iterate through all the offsets
				if i+1 < len(offs):
					testval = DataBlock(bytes[offs[i]:offs[i+1]]) #check to see if this offset points to another data block
				else:
					testval = DataBlock(bytes[offs[i]:])
					
				self.blocks.append(testval)
				"""	
				if testval.header: #if so, store that data block
					self.blocks.append(testval)
				else: #else, just store the bytes
					self.blocks.append(bytes[offs[i]:offs[i]])
					"""
		except ValueError: #if the bytes do not form a sub-block
			self.header = None
			self.bytes = bytes
			self.data = bytes
			self.blocks = None
				
class FileReader:
	def __init__(self, filename):
		fp = open(filename, 'rb')
		string = fp.read()
		fp.close()

		bytes = [ord(s) for s in string]
		
		self.data = DataBlock(bytes)
		
f=FileReader("wingldr.tim")
for b in f.data.blocks:
	print b.bytes[0:16]