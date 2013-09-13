# coding: utf-8

class SpanInfo
  attr_accessor :label
 def initialize(label, spanList)
  @label = label
  @spanList = spanList
 end 

 def getGraph
   graph = ""
   @spanList.length.times do
    graph += "*"
   end

   return graph
 end
 
 def getRatio(allCount)
   if allCount == 0 then
     return "0.00"
   else
     return sprintf("%.2f", (@spanList.length.quo(allCount) * 100))
   end
 end

 def getLength
   return @spanList.length
 end
end
