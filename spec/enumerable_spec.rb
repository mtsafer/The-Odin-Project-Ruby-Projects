require_relative "../lib/Enumerable"

describe "Enumerable" do

	let(:array) { [1,2,3,4,5] }

	describe "my_each" do
		context "times 2" do
			it "returns original array" do
				expect(array.my_each{ |x| print(x * 2) }).to eql array
			end
			it "executes block on elements" do
				expect{ array.my_each {|x| print(x * 2)}}.to output("246810").to_stdout
			end
		end
	end
	describe "my_each_with_index" do
		context "times index" do
			it "returns original array" do
				expect(array.my_each_with_index{ |x, i| print(x * 2) }).to eql array
			end
			it "uses index in block" do
				expect{ array.my_each_with_index { |x, i| print(x * i)}}.to output("0261220").to_stdout
			end
		end
	end
	describe "my_select" do
		context "find even" do
			it "returns only the even elements" do
				expect(array.my_select { |x| x % 2 == 0 }).to eql [2,4]
			end
			it "doesn't modify the array" do
				array.my_select { |x| x % 2 == 0 }
				expect(array).to eql [1,2,3,4,5]
			end
		end
	end
	describe "my_all?" do
		context "no block given" do
			it "returns true if all elements are truthy" do
				expect(array.all?).to eql true
			end
			it "returns false if any elements are falsy" do
				array = [1,2,3,4,5,nil]
				expect(array.all?).to eql false
			end
		end
		context "block is given" do
			it "returns true if all elements pass block" do
				expect(array.all? { |x| x != nil }).to eql true
			end
			it "returns false if any elements fail block" do
				expect(array.all? { |x| x % 2 == 0 }).to eql false
			end
		end
	end
	describe "my_any?" do
		context "no block given" do
			it "returns true if any elements are truthy" do
				expect(array.any?).to eql true
			end
			it "returns false if all all elements are false" do
				array = [nil]
				expect(array.any?).to eql false
			end
		end
		context "block is given" do
			it "returns true if any elements are truthy" do
				expect(array.any? { |x| x % 2 == 0 }).to eql true
			end
			it "returns false if all all elements are false" do
				expect(array.any? { |x| x == 0 }).to eql false
			end
		end
	end
	describe "my_count" do
		context "no block or argument given" do
			it "returns the length of the array" do
				expect(array.my_count).to eql 5
			end
		end
		context "argument given" do
			it "returns the number of matching elements" do
				expect(array.my_count(2)).to eql 1
			end
		end
		context "block given but no argument" do
			it "number of passing elements" do
				expect(array.my_count{ |x| x % 2 == 0 } ).to eql 2
			end
		end
		context "block and argument given" do
			it "gives a warning" do
				expect{array.my_count(1){|x|}}.to \
					output("warning: given block not used\n").to_stdout
			end
			it "ignores the block" do
				expect(array.my_count(2){ |x| x % 2 == 0 }).to eql 1
			end
		end
	end
end