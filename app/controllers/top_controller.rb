# coding: utf-8

class TopController < ApplicationController
  def index
    @message = "おはようございます！"
  end

  def about
  end

  def execute
    generator = AcGenerator.new
    generator.setRandomAccident
    generator.setDisplayResult
    generator.makeSpan
    generator.analysisSpan

    @displayResults = generator.displayResult
    @spanInfos = generator.spanInfos
    @spanCount = generator.spans.length
  end
end
