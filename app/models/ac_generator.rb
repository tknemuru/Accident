class AcGenerator < ActiveRecord::Base
  attr_accessor :displayResult, :spans, :spanInfos
  def setAccident generator
    @isAccidents = []
    1000.times do |i|
      @isAccidents[i] = generator.call(i)
    end
  end
  
  def setRandomAccident
    setAccident lambda { |i|
      return ((rand 10) == 0)
    }    
  end

  def setDisplayResult
    accidentLine = ""
    @isAccidents.each do |accident|
      accidentLine += (accident) ? "o" : "."
    end

    @displayResult = accidentLine.unpack("A100"*(accidentLine.length/100))
  end
  
  def makeSpan
    lastAccidentDay = -1
    @spans = []
    @isAccidents.each_with_index do |accident, today|
      if accident then
        @spans.push(today - (lastAccidentDay + 1)) if lastAccidentDay > -1
        lastAccidentDay = today
      end
    end
  end

  def analysisSpan
    @spanInfos = []
    DISPLAY_RANGE.each do |i, label|
      if i != DisplayRange::OVER_35 then
        @spanInfos.push(SpanInfo.new(label, @spans.find_all { |item| ((item >= (i * 5)) && (item < ((i + 1) * 5))) }))
      else
        @spanInfos.push(SpanInfo.new(label, @spans.find_all { |item| (item >= (i * 5)) }))
      end
    end
  end

  #module
  module DisplayRange
    UNDER_5 = 0
    UNDER_10 = 1
    UNDER_15 = 2
    UNDER_20 = 3
    UNDER_25 = 4
    UNDER_30 = 5
    UNDER_35 = 6
    OVER_35 = 7
  end

  #const
  DISPLAY_RANGE = {
    DisplayRange::UNDER_5 => '0<=',
    DisplayRange::UNDER_10 => '5<=',
    DisplayRange::UNDER_15 => '10<=',
    DisplayRange::UNDER_20 => '15<=',
    DisplayRange::UNDER_25 => '20<=',
    DisplayRange::UNDER_30 => '25<=',
    DisplayRange::UNDER_35 => '30<=',
    DisplayRange::OVER_35 => '35<='
  }
end
