require_relative "../tic-tac-toe/TicTacToe"

describe TicTacToe do
	let( :game ) { TicTacToe.new }
	describe "#has_ended?" do
		context "new game" do
			it "returns false" do
				expect(game.has_ended?).to eql false
			end
		end
		context "'X' won" do
			context "across" do
				it "returns 'X'" do
					game.set_spot(2,1,'X')
					game.set_spot(2,2,'X')
					game.set_spot(2,3,'X')
					expect(game.has_ended?).to eql "X"
				end
			end
			context "vertical" do
				it "returns 'X'" do
					game.set_spot(1,2,'X')
					game.set_spot(2,2,'X')
					game.set_spot(3,2,'X')
					expect(game.has_ended?).to eql "X"
				end
			end
			context "diagonal" do
				it "returns 'X'" do
					game.set_spot(1,1,'X')
					game.set_spot(2,2,'X')
					game.set_spot(3,3,'X')
					expect(game.has_ended?).to eql "X"
				end
			end
		end
		context "'O' won" do
			context "diagonal" do
				it "returns 'O'" do
					game.set_spot(1,3,'O')
					game.set_spot(2,2,'O')
					game.set_spot(3,1,'O')
					expect(game.has_ended?).to eql "O"
				end
			end
		end
		context "board is full and no winner" do
			it "returns 'nobody'" do
				(1..3).each do |i|
					(1..3).each { |j| game.set_spot(i,j,"M") }
				end
				expect(game.has_ended?).to eql "nobody"
			end
		end
		context "game is won by 'O' on the last turn" do
			it "returns 'O'" do
				game.set_spot(1,3,'O')
				game.set_spot(2,2,'O')
				game.set_spot(3,1,'O')
				(1..3).each do |i|
					(1..3).each { |j| game.set_spot(i,j,"M") }
				end
				expect(game.has_ended?).to eql "O"
			end
		end
	end
	describe "#set_spot" do
		context "center" do
			context "'X'" do
				it "sets the correct spot to 'X'" do
					game.set_spot(2,2,'X')
					expect(game.row2.column(2)).to eql "X"
				end
			end
		end
		context "corner" do
			context "'O'" do
				it "sets the correct spot to 'O'" do
					game.set_spot(3,3,'O')
					expect(game.row3.column(3)).to eql "O"
				end
			end
		end
		context "input is a number but not on the board" do
			context "invalid row" do
				it "displays 'invalid row'" do
					expect{game.set_spot(4,2,'X')}.to output("invalid row\n").to_stdout
				end
			end
		end
		context "the spot is already taken" do
			it "displays 'Spot taken!'" do
				game.set_spot(1,1,"X")
				expect{game.set_spot(1,1,"O")}.to output("Spot taken!\n").to_stdout
			end
		end
	end
end
