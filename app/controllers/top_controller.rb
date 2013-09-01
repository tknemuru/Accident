# coding: utf-8

class TopController < ApplicationController
  def index
    @message = "おはようございます！"
  end

  def about
  end

  def execute
    @result = []
    @result[0] = ""
    @lastAccidentDay = 0
    @today = 0
    @span = []
    @span[0] = ""

    1000.times do |i|
      @result[@result.length - 1] += accidentDisp(i)
      @result[@result.length] = "" if ((i % 100) == 0) && (i != 0)
    end

    spanAnalysis
  end

  private
  def accidentDisp(today)
    if ((rand 10) == 0) then
      @span[@span.length - 1] = (today - @lastAccidentDay)
      @lastAccidentDay = today
      @span[@span.length] = 0
      return "o"
    else
      return "."
    end
  end
  
  def spanAnalysis()
    @spanCount = []
    8.times do |i|
      groupd_span = @span.find_all { |item| ((item >= (i * 5)) && (item < ((i + 1) *5))) }
      @spanCount[i] = ""
      groupd_span.length.times do
        @spanCount[i] += "*"
      end

      @spanCount[i] = (i * 5).to_s + "<= |" + @spanCount[i] +  groupd_span.length.to_s + "(" + sprintf("%.2f", (groupd_span.length.quo(@span.length) * 100)) + "%)"
    end
  end
end
