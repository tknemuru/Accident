require 'test_helper'

class AcGeneratorTest < ActiveSupport::TestCase
  test "表示用配列の確認" do
    generator = AcGenerator.new()
    generator.setRandomAccident
    generator.setDisplayResult

    # 表示する行は１０行
    assert (generator.displayResult.length == 10)

    # 行は"."と"o"のみで構成された100文字の文字列
    generator.displayResult.each do |result|
      assert (/^(\.|o){100}$/ =~ result)
    end
  end

  test "分析値の確認" do
    # 全部アクシデント
    analysisTest("0<=", lambda { |i| return true })
    
    # 4つごとにアクシデント
    analysisTest("0<=", lambda { |i| return ((i % 5) == 0) })
    
    # 5つごとにアクシデント
    analysisTest("5<=", lambda { |i| return ((i % 6) == 0) })

    # 9個ごとにアクシデント
    analysisTest("5<=", lambda { |i| return ((i % 10) == 0) })

    # 10個ごとにアクシデント
    analysisTest("10<=", lambda { |i| return ((i % 11) == 0) })

    # 35個ごとにアクシデント
    analysisTest("35<=", lambda { |i| return ((i % 36) == 0) })

    # 全部正常
    analysisTest("全部正常の場合は間隔なし", lambda { |i| return false })
  end
  
  def analysisTest(label, makeAccident)
    generator = AcGenerator.new()
    generator.setAccident makeAccident
    generator.makeSpan
    generator.analysisSpan
    allCount = generator.spans.length
    generator.spanInfos.each do |spanInfo|
      if spanInfo.label == label then
        assert(spanInfo.getRatio(allCount) == "100.00")
      else
        assert(spanInfo.getRatio(allCount) == "0.00")
      end
    end
  end
end
