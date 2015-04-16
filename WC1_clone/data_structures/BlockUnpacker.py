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
	def __init__(self, bytes, index = 0):
		self.bytes = bytes
		self.offsets = []
		self.offsets.append(SwapEndian(bytes[0:3])) #get the first offset in the table, to find the end of the table
		
		if self.offsets[0] > len(bytes):
			raise ValueError
			
		for i in range(4, self.offsets[0]-index, 4): #get the rest of the offsets
			self.offsets.append(SwapEndian(bytes[i:i+3]))
			
	
class Header:
	def __init__(self, bytes):
		self.bytes = bytes
		self.blocksize = len(bytes)
		
		if self.blocksize == SwapEndian(bytes[0:3]):
			self.table = Table(bytes[4:], 4).offsets
		else:
			self.table = Table(bytes).offsets
			
		if self.table[0] == 0: #check to make sure the table has valid offsets
			raise ValueError
		
		for t in self.table:
			if t > self.blocksize:
				raise ValueError
	
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

class SaveBlock:
	def __init__(self, bytes):
		self.header = None
		self.bytes = bytes
		self.data = bytes
		
		self.blocks = [bytes[i*828:(i+1)*828] for i in range(0,8)]
		
class SaveReader:
	def __init__(self, filename):
		fp = open(filename, 'rb')
		string = fp.read()
		fp.close()

		bytes = [ord(s) for s in string]
		
		self.data = SaveBlock(bytes)