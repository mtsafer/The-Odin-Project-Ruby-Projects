module Enumerable

	def my_each
		return self unless block_given?
		for i in self do
			yield(i)
		end
		self
	end

	def my_each_with_index
		return self unless block_given?
		for i in 0...self.length
			yield(self[i], i)
		end
		self
	end

	def my_select
		return self unless block_given?
		selection = []
		self.my_each{|item| selection<<item if yield(item)}
		selection
	end

	def my_all?
		pass = true
		self.my_each{|item| pass = false unless item} unless block_given?
		self.my_each{|item| pass = false unless yield(item)} if block_given?
		pass
	end

	def my_any?
		pass = false
		self.my_each{|item| pass = true if item} unless block_given?
		self.my_each{|item| pass = true if yield(item)} if block_given?
		pass
	end

	def my_none?
		pass = true
		self.my_each{|item| pass = false if item} unless block_given?
		self.my_each{|item| pass = false if yield(item)} if block_given?
		pass
	end

	def my_count(arg = nil)
		puts "warning: given block not used" if arg && block_given?
		return self.length unless block_given? || arg
		return self.my_select{|item| item == arg}.length if arg
		return self.my_select{|item| yield(item)}.length if block_given? && !arg
	end

	def my_map(proc=nil)
		return self unless proc.class == Proc || block_given?
		new_self = []
		for i in self do
			new_self<<proc.call(i) if proc.class == Proc
			new_self<<yield(i) if block_given? && proc.class != Proc
		end
		new_self
	end

	def my_inject(memo = nil)
		skip_first = true unless memo
		memo ||= self.first
		self.my_each do|i|
			memo = yield(memo,i) unless skip_first
			skip_first = false if skip_first
		end
		memo
	end

end

def multiply_els(array)
	array.my_inject{|product, n| n*product}
end