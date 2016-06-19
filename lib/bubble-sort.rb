# Build a method #bubble_sort that takes an array
# and returns a sorted array.It must use the bubble sort methodology.

# uses the bubble sort methodology to sort and return the given array
def bubble_sort(array)
	for i in 0...array.length
		array.map.with_index do |item, index|
			if array[index+1] != nil && item > array[index+1]
				temp = array[index+1]
				array[index+1] = item
				array[index] = temp
			end
		end
	end
	array
end

# uses the bubble sort methodology to sort and return the given array
# takes a block with two parameters, left and right, to customize sorting
def bubble_sort_by(array)
	for i in 0...array.length
		array.map.with_index do |item, index|
			if array[index+1] != nil && yield(item, array[index+1]) > 0
				temp = array[index+1]
				array[index+1] = item
				array[index] = temp
			end
		end
	end
	array
end

puts bubble_sort([4,3,78,2,0,2])
puts bubble_sort_by(["hi","hello","hey"]){ |left,right| left.length - right.length }