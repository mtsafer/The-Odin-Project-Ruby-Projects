require_relative "../lib/Project-1"

describe Cipher do
	describe "#encrypt" do
		let(:ceasar) { Cipher.new }
		context "a" do
			context "given magnitude of 5" do
				it "returns 'f'" do
					expect(ceasar.encrypt("a",5)).to eql "f"
				end
			end
			context "given magnitude 0f -2" do
				it "returns 'y'" do
					expect(ceasar.encrypt("a",-2)).to eql "y"
				end
			end
		end
		context "z" do
			context "given a magnitude of 2" do
				it "returns 'b'" do
					expect(ceasar.encrypt("z",2)).to eql "b"
				end
			end
		end
		context "AbCdEfG" do
			context "given a magnitude of 1" do
				it "preserves capitalization" do
					expect(ceasar.encrypt("AbCdEfG",1)).to eql "BcDeFgH"
				end
			end
		end
		context "!a@b#C$D%f" do
			context "given a magnitude of 1" do
				it "only modifies letters" do
					expect(ceasar.encrypt("!a@b#C$D%f",1)).to eql "!b@c#D$E%g"
				end
			end
		end
	end
end