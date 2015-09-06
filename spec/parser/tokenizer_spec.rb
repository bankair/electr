require 'spec_helper'

include Electr

describe Tokenizer do

  describe "#has_more_token?" do
    it "returns true when a token is available" do
      tkr = Tokenizer.new("2 3")
      expect(tkr.has_more_token?).to eq true
      tkr.next_token
      expect(tkr.has_more_token?).to eq true
    end

    it "returns false when no more tokens are available" do
      tkr = Tokenizer.new("0")
      tkr.next_token
      expect(tkr.has_more_token?).to eq false
    end
  end

  specify "21 300" do
    tkr = Tokenizer.new("21 300")
    expect(tkr.next_token).to eq "21"
    expect(tkr.next_token).to eq "300"
  end

  specify "2 0.6" do
    tkr = Tokenizer.new("2 0.6")
    expect(tkr.next_token).to eq "2"
    expect(tkr.next_token).to eq "0.6"
  end

  specify ".6" do
    tkr = Tokenizer.new(".6")
    expect(tkr.next_token).to eq ".6"
  end

  specify "2 .6" do
    tkr = Tokenizer.new("2 .6")
    expect(tkr.next_token).to eq "2"
    expect(tkr.next_token).to eq ".6"
  end

  specify "2 0.6 3" do
    tkr = Tokenizer.new("2 0.6 3")
    expect(tkr.next_token).to eq "2"
    expect(tkr.next_token).to eq "0.6"
    expect(tkr.next_token).to eq "3"
  end

  specify "2 + 3" do
    tkr = Tokenizer.new("2 + 3")
    expect(tkr.next_token).to eq "2"
    expect(tkr.next_token).to eq "+"
    expect(tkr.next_token).to eq "3"
  end

  specify "2 pi" do
    tkr = Tokenizer.new("2 pi")
    expect(tkr.next_token).to eq "2"
    expect(tkr.next_token).to eq "pi"
  end

  specify "11K 22k 33kΩ" do
    tkr = Tokenizer.new("11K 22k 33kΩ")
    expect(tkr.next_token).to eq "11K"
    expect(tkr.next_token).to eq "22k"
    expect(tkr.next_token).to eq "33kΩ"
  end

  specify "100R 200Ω" do
    tkr = Tokenizer.new("100R 200Ω")
    expect(tkr.next_token).to eq "100R"
    expect(tkr.next_token).to eq "200Ω"
  end

  specify "10uF 100u 470μF 1000μ 10pF 100p" do
    tkr = Tokenizer.new("10uF 100u 470μF 1000μ 10pF 100p")
    expect(tkr.next_token).to eq "10uF"
    expect(tkr.next_token).to eq "100u"
    expect(tkr.next_token).to eq "470μF"
    expect(tkr.next_token).to eq "1000μ"
    expect(tkr.next_token).to eq "10pF"
    expect(tkr.next_token).to eq "100p"
  end

  specify "sqrt(11k 22k)" do
    tkr = Tokenizer.new("sqrt(11k 22k)")
    expect(tkr.next_token).to eq "sqrt"
    expect(tkr.next_token).to eq "("
    expect(tkr.next_token).to eq "11k"
    expect(tkr.next_token).to eq "22k"
    expect(tkr.next_token).to eq ")"
  end

  specify "1 / (2 pi 0.5uF sqrt(11K 22K))" do
    tkr = Tokenizer.new("1 / (2 pi 0.5uF sqrt(11K 22K))")
    expect(tkr.next_token).to eq "1"
    expect(tkr.next_token).to eq "/"
    expect(tkr.next_token).to eq "("
    expect(tkr.next_token).to eq "2"
    expect(tkr.next_token).to eq "pi"
    expect(tkr.next_token).to eq "0.5uF"
    expect(tkr.next_token).to eq "sqrt"
    expect(tkr.next_token).to eq "("
    expect(tkr.next_token).to eq "11K"
    expect(tkr.next_token).to eq "22K"
    expect(tkr.next_token).to eq ")"
    expect(tkr.next_token).to eq ")"
  end

end