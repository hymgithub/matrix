class Element
     @value
     @times 
     @weight
     def initialize value,times
	@value = value
	@times = times
	@weight = 0
     end
     def value
	@value
     end

     def times
	@times
     end
	
     def addTimes
	@times+=1
     end
     def minusTimes
       @times -=1
     end
     def weight 
	@weight
     end
     def setweight weight
	@weight = weight
     end
end

class BParameter
     @paramname
     @elementsArr
     def initialize paramname
	@paramname = paramname
        @elementsArr = Array.new
     end

     def paramname 
	@paramname
     end

     def addElement element
      @elementsArr << element
     end

     def elementsArr
      @elementsArr
     end	     
end

class BParameters
    @paramsArr 
    def initialize 
    @paramsArr = Array.new
    end
    def paramsArr
    @paramsArr
    end

    def addParam  param
	@paramsArr << param
    end

end

class Pair
     @firstValue
     @secondValue
     @isVisited
     def initialize firstvalue,secondvalue
         @firstValue = firstvalue
	 @secondValue = secondvalue
         @isVisited = false
     end
     
     def firstValue 
	@firstValue
     end
     def secondValue
	@secondValue
     end
     def isVisited
	@isVisited
     end
   
     def setIsVisited
	@isVisited = true
     end
     def setDisable
      @isVisited = "disabled"
     end
end

class Pairs
     @firstParam
     @secondParam
     @pairsArr
     def initialize firstparam,secondparam
	@firstParam = firstparam
 	@secondParam = secondparam
	@pairsArr = Array.new
     end
     def addPair pair
	@pairsArr << pair
     end
     def firstParam
	@firstParam
     end
     def secondParam
	@secondParam
     end
     def pairsArr
	@pairsArr
     end
end

class Record
   @valuesArr
   @isNew
   @weight
   @coverage
   def initialize 
    @valuesArr = Array.new
    @isNew = 0
    @weight=0
    @coverage=100
   end  
   def setValue index,value
    @valuesArr[index] = value 
   end
   def valuesArr
   @valuesArr
   end
   def isNew
   @isNew
   end
   def setTag tg
    @isNew = tg
   end
   def weight
   @weight
   end
   def coverage
	@coverage
   end
  
   def setcoverage co
	@coverage= co
   end
   def setwe wt
	@weight = wt
   end

   def setweight wt
   @weight=@weight+wt
   end
   
end

class Records
   @recordsArr
   def initialize 
   @recordsArr = Array.new
   end
   def addRecord record
   @recordsArr << record
   end
   def recordsArr
   @recordsArr
   end

   
end
class Manager 
     @parameters #参数
     @pairs   #产生到pairs 同时也是UC
     @records #存放最终结果 
     @ucrecords #存放原始的迪卡尔积结果     
     @maxparam 
     @maxelement
     @maxloopnum  #max loop num used for generateNumCase and getMostCover
     @haslimit 
     @limitvaluesArr #new add
     @useweight #if have same occur numbers,whether use their weight to select #add by chuangye 
     @counterIndex 
     @counter
     


     @musthavelimit # must have limit foreaxmple  a b  must have
     @musthavevaluesArr
    
     def initialize
	@parameters = BParameters.new
        @pairs = Array.new
        @records = Records.new
        @maxparam = 0
	@maxelement = 0
        @limitvaluesArr = Array.new
        @maxloopnum = 50
        @useweight=1
        @counter = Array.new(100,0)
	@counterIndex = @parameters.paramsArr.length
	@ucrecords = Records.new
     end
     def parameters
	@parameters
     end
     def pairs
	@pairs
     end
     def records
	@records
     end
     def ucrecords
        @ucrecords
     end
      
     def records
        @records
     end

     def haslimit
        @haslimit
     end
     def limitvaluesArr
      @limitvaluesArr
     end
     def sethaslimit haslimit
      @haslimit = haslimit
     end 
     def setlimitvaluesArr limitvaluesArr
      @limitvaluesArr = limitvaluesArr
     end

     def musthavelimit
      @musthavelimit
     end

     def musthavevaluesArr
      @musthavevaluesArr
     end
    

     #input the parameters 
     #function_inputParameters start
     #the number of parameters
     def inputParameters  paramsnum  


      #input parameters      
	

       	
      #input must not have limit info
      puts "has (must not have type)  limit? please input 0 or 1(0 means no limit,1 means has limit)"
      haslimit = gets
      if haslimit.to_i == 1
        @haslimit = true
         puts "please input the group num of limitValue"
         gnum = gets
         inputMustNotHaveLimitValues gnum.to_i
      else
        @haslimit = false
      end


      #input must have limit info
=begin      puts "has (must  have type)  limit? please input 0 or 1(0 means no limit,1 means has limit)"
      musthavelimit = gets
      if musthavelimit.to_i == 1
        @musthavelimit = true
         puts "please input the group num of limitValue"
         gnum = gets
         inputMustHaveLimitValues gnum.to_i
      else
        @musthavelimit = false
      end
=end
      

     end
     #function_inputParameters end

     def inputMustNotHaveLimitValues limitgroupnum

        #new add limit start
      
      if @haslimit # if has limit then input the values of limit ,and store these value to @limitvaluesArr
       
        gindex = 0 
        while gindex < limitgroupnum do
            puts "please input the index A parameters and B parameters "
            aindex = gets
            bindex = gets
            puts "please input the num of limitValues "     
            limitnum = gets
            
            lindex = 0
            tempairs = Pairs.new aindex.to_i,bindex.to_i
                while lindex < limitnum.to_i do
                  puts "input the value of limit A"
                  avalue = gets 
                  puts "input the value of limit B"
                  bvalue = gets           
                  pair = Pair.new avalue,bvalue
                  tempairs.pairsArr << pair
                  lindex += 1
                  puts lindex
                end              
            @limitvaluesArr << tempairs
            gindex+=1
        end
      end
       #new add limit end   


     end



    

    def inputMustHaveLimitValues limitgroupnum

        #new add limit start
      
      if @musthavelimit # if has limit then input the values of limit ,and store these value to @limitvaluesArr
       
      #input the limit values (not implement)
      end
       #new add limit end   


     end



     #function_generatePairs start
     #generate pais
     def generatePairs
        for i in 0...@parameters.paramsArr.length-1 do  
           for j in i+1 ...@parameters.paramsArr.length do
               tmppairs = Pairs.new i,j
               for k in 0...@parameters.paramsArr[i].elementsArr.length do
                  for h in 0...@parameters.paramsArr[j].elementsArr.length do                   
                      tmppair = Pair.new k,h                                  #there we store the index of value but not the true value
                      @parameters.paramsArr[i].elementsArr[k].addTimes
                      @parameters.paramsArr[j].elementsArr[h].addTimes
                      tmppairs.addPair tmppair                              #temppairs just like ABpairs  not all AB AC BC
                    
                   end
               end
              @pairs << tmppairs                                             #@pairs is all the pairs  like AB AC BC 
          end
      end

      #if  has limit then  update the pairs with limit conditions
      if @haslimit
      	puts  "update pairs with limit...."
        updatePairsWithLimit
      end
   end

   #output the parameters 
=begin   def generateparameter
       for i in 0...@parameters.paramsArr.length do
              print @parameters.paramsArr[i].paramname
           for j in 0...@parameters.paramsArr[i].elementsArr.length do
            print @parameters.paramsArr[i].elementsArr[j].value
            print @parameters.paramsArr[i].elementsArr[j].times
           end
       end
   end
=end



     #function_getMostOccur start  	 
     # get the index of parameter and its value index of has max times 
     def getMostOccur 
       tmpArry=[]
       tmpWArry=[];
	     @maxparam =0 #use for store the param
       @maxelement =0 #use for store the element
		    i=0
        while i<@parameters.paramsArr.length do
      	    temelementslength = @parameters.paramsArr[i].elementsArr.length	
      	    j=0
            while j < temelementslength do		
                    if @parameters.paramsArr[i].elementsArr[j].times == @parameters.paramsArr[@maxparam].elementsArr[@maxelement].times
                           
                           tmpArry << [i , j]
                   elsif @parameters.paramsArr[i].elementsArr[j].times > @parameters.paramsArr[@maxparam].elementsArr[@maxelement].times
                           tmpArry.clear
                           tmpArry << [i , j]
		                  	   @maxparam = i 
                           @maxelement = j
                     end	  
              j+=1
            end
            i+=1
        end
       #add by chuangye -----------------------------start
       if @useweight==1
          maxweight=@parameters.paramsArr[tmpArry[0][0]].elementsArr[tmpArry[0][1]].weight
          for k in 0...tmpArry.length do
                if @parameters.paramsArr[tmpArry[k][0]].elementsArr[tmpArry[k][1]].weight==maxweight
                    tmpWArry << tmpArry[k]
                elsif @parameters.paramsArr[tmpArry[k][0]].elementsArr[tmpArry[k][1]].weight>maxweight
                     tmpWArry.clear
                     tmpWArry << tmpArry[k]
                end
          end
        tmp=randchar(0,tmpWArry.length-1)
        @maxparam = tmpWArry[tmp][0]
        @maxelement = tmpWArry[tmp][1]
       else
       #add by chuangye -----------------------------end
       tmp = randchar(0 , tmpArry.length-1)
       @maxparam = tmpArry[tmp][0]
       @maxelement = tmpArry[tmp][1]
     end
   end
     #function_getMostOccur end


     #function_generateSequence start
     #generate the sequence	
     def generateSequence 
		sequenceArr = Array.new  # new the length of parameters array and the 0 is used for record
	        sequenceArr[0]  = @maxparam
	       	temparameterlen = @parameters.paramsArr.length 
      		#because the firsrameters.paramsArr[i].paramname
      		#temparameter is the maxparameter so  we just generate the rest parameters' sequence 
		      index = 1
      		while index < temparameterlen do
      			#generate the randnum
      		  #	chars = (0..temparameterlen-1).to_a
            #	temrandnum = chars[rand(chars.size)]
      		  temrandnum = randchar(0,temparameterlen-1)
      			if temrandnum != @maxparam 	 
      				j = 1
      				isexist = false
        				while j < index   #check whether the temrandnum is already generated
          					if sequenceArr[j]==temrandnum
          					  isexist = true
                      break
          					end        					
        					j+=1
        				end
        				if !isexist 
        					  sequenceArr[index] = temrandnum
        						index +=1      					
        				end	
      			end
      		end	
		      return sequenceArr         
     end
     #function_generateSequence end
	


     #function_generateCase start
     def generateCase
	record = Record.new
        record.valuesArr[@maxparam]=@maxelement
	      sequenceArr = generateSequence
	      i = 1
        tmpArry=[]
		flag = 1
      	while (i < @parameters.paramsArr.length ) do
            	   paramindex = sequenceArr[i]
                 tmpArry = setNumFromPairs record,sequenceArr,i  # set the num of sequenceArr setMaxnumFromPairs is a function and sequenceArr, i are parameters
				 
                 maxelementindex= getMaxNum paramindex ,tmpArry
				 if maxelementindex != -1				 
                 record.valuesArr[paramindex] = maxelementindex 
				 elsif maxelementindex ==-1
				 flag = 0
				 end
      	         i+=1
      	end
        if flag==0
			return -1
		elsif flag==1
		   return record
		end         
     end
     #function_generateCase end     
     
     #function_setMaxnumFromParis used in generateCase function
     def setNumFromPairs record, sequenceArr,index
       paramindex=sequenceArr[index]
       tmpArry = []
       num =0
       tag = 1
       flag=1
       for i in 0...@parameters.paramsArr[paramindex].elementsArr.length do
		   flag=1
          for j in 0...index do
              tag =1
              for k in 0...@pairs.length do #for k do start
                    if @pairs[k].secondParam == paramindex and @pairs[k].firstParam == sequenceArr[j] ####if start
                         for h in 0...@pairs[k].pairsArr.length do #for h do start
                                if @pairs[k].pairsArr[h].secondValue == i and @pairs[k].pairsArr[h].firstValue ==record.valuesArr[sequenceArr[j]] and @pairs[k].pairsArr[h].isVisited == false
                                         num+=1 
                                         tag=0
                                         break   #break for h
                                elsif @pairs[k].pairsArr[h].secondValue ==i and @pairs[k].pairsArr[h].firstValue == record.valuesArr[sequenceArr[j]] and @pairs[k].pairsArr[h].isVisited == 'disabled'
                                         flag=0
                                         break  #break for h
                                end       
                         end  #for h do end
                   elsif @pairs[k].firstParam == paramindex and @pairs[k].secondParam == sequenceArr[j] ####ifels
                        for h in 0...@pairs[k].pairsArr.length do ##for h do start                       
                            if @pairs[k].pairsArr[h].firstValue == i and @pairs[k].pairsArr[h].secondValue ==record.valuesArr[sequenceArr[j]] and @pairs[k].pairsArr[h].isVisited == false                              
                                              num+=1
                                              tag=0
                                              break  #break for h
                           elsif @pairs[k].pairsArr[h].firstValue ==i and @pairs[k].pairsArr[h].secondValue ==record.valuesArr[sequenceArr[j]] and @pairs[k].pairsArr[h].isVisited == 'disabled'
                                            flag=0
                                            break   #break for h
                           end
                        end ##for h do end
                     if tag == 0 or flag ==0
                         break  #break for k
                     end
                   end ####if end                
              end #for k do end
             if flag ==0
                break  #break for j
            end
        end
        if flag ==1
           tmpArry << [i , num]
        end
        num=0
      end
    return tmpArry
   end
     #function_setMaxnumFromParis
     

    #function_getMaxNum begin used in generateCase function
    def getMaxNum paramindex,tmpArry
        maxtag = 0
        maxnum = 0
        tmpWArry=[]
        tmp=Array.new
        for i in 0 ...tmpArry.length do
             if tmpArry[i][1] == maxnum
                tmp << tmpArry[i][0]
             elsif tmpArry[i][1] > maxnum
                 maxtag = tmpArry[i][0]
                 maxnum = tmpArry[i][1]
                 tmp.clear
                 tmp << maxtag
            end       
        end

      if tmp.length ==0
	return 0
     else
        #add by chuangye --------------------------start
        if @useweight==1
           maxweigth=@parameters.paramsArr[paramindex].elementsArr[tmp[0]].weight
           for j in 0...tmp.length do
              if @parameters.paramsArr[paramindex].elementsArr[tmp[j]].weight==maxweigth
                 tmpWArry << tmp[j]
              elsif @parameters.paramsArr[paramindex].elementsArr[tmp[j]].weight>maxweigth
                 tmpWArry.clear
                 tmpWArry << tmp[j]
              end
           
          end
         return tmpWArry[randchar(0,tmpWArry.length-1)]
        else
       #add by chuangye ----------------------------end
         return tmp[randchar(0,tmp.length-1)]
	end

    #  return tmp[randchar(0,tmp.length-1)]
   end
 end
    # function_getMaxNum end
    	


   #functon_generateNumCases start
   # generate all the cases without restrict
     def generateNumCases  
      time1 = Time.now # used for test
      time11 = Time.new # used for test
      puts time1# used for test

	   while !isEmptyOfUC do
          tmprecords=Records.new           #new a Record used for store the results
          getMostOccur                     #get the most occur store in @maxparam and @maxelement
           for i in 0...@maxloopnum do              #generate @maxloopnum records and later will random select one

            

            recorde = generateCase
            if(recorde !=-1)
                tmprecords.recordsArr << recorde
            end
           end
          flag = getMostCover tmprecords
          @records.recordsArr << tmprecords.recordsArr[flag]
          updateUC  tmprecords.recordsArr[flag]
          tmprecords.recordsArr.clear
      end
      
      #puts 'list:'
      outputcase 
      #print'total number:'
      #puts @records.recordsArr.length

      #puts "start time"  #design for test start
      #puts time11
      time22 = Time.new
      #puts "end time"
      
      #puts time22
      time2 = Time.now
      puts time2-time1    #design for test end
      @usetime = time2-time1
     end
      #function_generateNumCases end
   


   #functon_getMostCover start
   def getMostCover records
     numset = []
     num = 0
     wArry=[];
     for i in 0...@maxloopnum do
        for j in 0...@parameters.paramsArr.length do
           for k in j+1 ...@parameters.paramsArr.length do
              for n in 0...@pairs.length do
                 if @pairs[n].firstParam ==j and @pairs[n].secondParam ==k
                    for m in 0...@pairs[n].pairsArr.length do
               if records.recordsArr[i].valuesArr[j] == @pairs[n].pairsArr[m].firstValue and records.recordsArr[i].valuesArr[k] ==@pairs[n].pairsArr[m].secondValue and @pairs[n].pairsArr[m].isVisited== false
                               num+=1
                               
               end
                    end
                 end
              end
           end
        end
      numset << num
      num =0
     end
     maxtag=0
     maxnum=0
     max = Array.new
     for i in 0...@maxloopnum do
         if numset[i] == maxnum
            max << i        
         elsif numset[i] > maxnum
            maxnum = numset[i]
            max.clear
            max << i
        end      
     end
     #addb by chuangye ----------------------start
   if @useweight==1
     for h in 0...max.length do
        weight=0
        for p in 0...@parameters.paramsArr.length do
            pos=records.recordsArr[max[h]].valuesArr[p]
           weight+=@parameters.paramsArr[p].elementsArr[pos].weight
             
        end
        wArry << [max[h],weight]
     end
     maxweight=wArry[0][1]
     maxArry=[]
     for x in 0... wArry.length do
          if wArry[x][1]==maxweight
                  maxArry << wArry[x][0]
          elsif wArry[x][1]==maxweight
                  maxArry.clear
                  maxArry << wArry[x][0]
          end
 
     end
     tag= randchar(0,maxArry.length-1)
     return maxArry[tag]
   else 
     #add by chuangye ------------------------end
     tag = randchar(0,max.length-1)
     return max[tag]
   end
  end
 
   #functon_getMostCover end

  #function_supplementaryCase start
  def supplementaryCase records     #generate the supplementary set for selected records 
     num=@records.recordsArr[0].valuesArr.length
     
     recordset = Records.new
     tagset = []
      # add the @records and selected records (just the inputparameter 'records' into the recordset )                                        
     for i in 0...@records.recordsArr.length do          #add the @records to recordset and set tagset=1
             recordset.recordsArr <<  @records.recordsArr[i]
             tagset << 1
     end
     for j in 0...records.recordsArr.length do            #add the records to recordset and set tagset=0
            recordset.recordsArr <<  records.recordsArr[j]
            tagset << 0
     end

    sum  = @parameters.paramsArr.length*(@parameters.paramsArr.length-1)/2
    print 'sum='
    puts sum



    for i in 0...recordset.recordsArr.length do
       isexist=0
      for h in 0...@parameters.paramsArr.length do
        for k in h+1 ...@parameters.paramsArr.length do
          for j in i+1 ...recordset.recordsArr.length do
            if recordset.recordsArr[i].valuesArr[h]== recordset.recordsArr[j].valuesArr[h] and recordset.recordsArr[i].valuesArr[k] == recordset.recordsArr[j].valuesArr[k]
                isexist+=1       
            end
          end
        end
      end
      if isexist >=sum
         tagset[i]=0
      end 
    end
      result = Records.new
     for m in 0...tagset.length do
        if tagset[m]==1
          result.recordsArr << recordset.recordsArr[m]
        end
    end
    return result
  end
 #function_supplementartCase end
 


 def updatePairsWithLimit
  if @haslimit
    limitgroupnum = @limitvaluesArr.length          #limitvaluesArr length 
    lgindex = 0
    while lgindex < limitgroupnum do               #for each limitvalue  do
      pairs = @limitvaluesArr[lgindex]             #limit pairs
      firstParam = pairs.firstParam                #limit pairs firstParam
      secondParam = pairs.secondParam              #limit pairs secondParam
      limitnum  = pairs.pairsArr.length            #limit pairs's pair length 
      lindex = 0
      while lindex < limitnum do                   #foreach pair do 
        puts "lindex="
        puts lindex
        pairsnum = @pairs.length
        pindex =0
        while pindex < pairsnum do
          mpairs = @pairs[pindex]                   
          
          if mpairs.firstParam==firstParam&&mpairs.secondParam==secondParam 
                valuesnum = mpairs.pairsArr.length
                puts "valuesnum="
                puts valuesnum
                i =0
                while i < valuesnum do

                   
                     
                   


                      if @parameters.paramsArr[firstParam].elementsArr[mpairs.pairsArr[i].firstValue].value.to_i == pairs.pairsArr[lindex].firstValue.to_i and @parameters.paramsArr[secondParam].elementsArr[mpairs.pairsArr[i].secondValue].value.to_i ==pairs.pairsArr[lindex].secondValue.to_i
                      @pairs[pindex].pairsArr[i].setDisable   
                   



                      end 
                i+=1
                end

          end
          pindex+=1
        end

        lindex+=1
      end
      lgindex+=1
    end

  end




 end


#function_musthaveParams start
def musthaveParams 
  
end
#functon_musthaveParams end
 
 
 
 #function_checkLimit start
      def checkMustHaveNotLimit record
        isfitted = false
          if @haslimit 
          limitnum = @limitvaluesArr.length
          i = 0
            while i < limitnum do
              tempairs  = @limitvaluesArr[i]
              firstParam = tempairs.firstParam
              secondParam = tempairs.secondParam
              valueslen = tempairs.pairsArr.length 
              j = 0
              while j < valueslen do
                  if  tempairs.pairsArr[j].firstValue == @parameters.paramsArr[firstParam].elementsArr[ record.valuesArr[firstParam] ]&&tempairs.pairsArr[j].secondValue==@parameters.paramsArr[secondParam].elementsArr[record.valuesArr[secondParam]]

                     isfitted = true 
                     break;
                  end                    
                    j +=1
              end

              i+=1
            end
          else
            isfitted = false
          end

        return isfitted

      end
#function_checkLimit end




#update the ucpairstable with the record
#function_updateUC start
 def updateUC  record
     for i in 0...record.valuesArr.length do
        for j in i+1...record.valuesArr.length do
           for k in 0...@pairs.length do
               if @pairs[k].firstParam == i and @pairs[k].secondParam == j
                  for h in 0...@pairs[k].pairsArr.length do
                     if @pairs[k].pairsArr[h].firstValue == record.valuesArr[i] and @pairs[k].pairsArr[h].secondValue == record.valuesArr[j]
                        @parameters.paramsArr[i].elementsArr[record.valuesArr[i]].minusTimes
                        @parameters.paramsArr[j].elementsArr[record.valuesArr[j]].minusTimes
                        @pairs[k].pairsArr[h].setIsVisited 
                     end
                  end
               end                 
           end
        end
     end
 end
#function_updateUC end


#function_isEmptyOfUC
#return whether the UCpairsTable is empty
  def isEmptyOfUC  
	      isempty = true
        for i in 0...@pairs.length do
             for k in 0...@pairs[i].pairsArr.length do
               if @pairs[i].pairsArr[k].isVisited == false
                  isempty = false
                  return isempty
               end
             end
        end
  end

#function_isEmptyOfUC


   def getResults  #get the not limit Results
       @records
   end

   def getResultsWithMustHaveLimit 
   end

   def getResultsWithMustNotLimit
   end
     





  #out put the parameters design for test
  #function_start 
   def outputParameters
    	i=0
  		while i < @parameters.paramsArr.length do
  			temparameter = @parameters.paramsArr[i]
  			elementlen = temparameter.elementsArr.length
        print "parameters name :"
        puts  @parameters.paramsArr[i].paramname
  			j=0
        print "value "
        print "times "
  			while j<elementlen.to_i do
          puts " "
  				print @parameters.paramsArr[i].elementsArr[j].value
          print "  "
          puts @parameters.paramsArr[i].elementsArr[j].times
  				j+=1
  			end 
  			i+=1
  		end
   end
  #function end



    #function_outputPairs start
    def outputPairs
     for i in 0...@pairs.length do
         print 'canshu:'
         print @pairs[i].firstParam 
         print ' '
         puts @pairs[i].secondParam
         for j in 0...@pairs[i].pairsArr.length do
               print @pairs[i].pairsArr[j].firstValue
               print @pairs[i].pairsArr[j].secondValue
               puts @pairs[i].pairsArr[j].isVisited
              
          end
      end
    end
   #function_outputPairs  end



    #function_outputcase start
    def outputcase 
       for i in 0...@records.recordsArr.length do

           isfit = checkMustHaveNotLimit @records.recordsArr[i]
                      

                for j in 0...@records.recordsArr[i].valuesArr.length do
                   print parameters.paramsArr[j].elementsArr[@records.recordsArr[i].valuesArr[j]].value
                   print ' '
                 end
                  puts '    '
          
        end
    end
  #function _outputcase end 



  #tools for this class
  #generate the rand num between first and last
   def randchar (first,last)	  
  	chars = (first..last).to_a
        randchar = chars[rand(chars.size)]
        return randchar
   end 
#add by chuangye start-----------------------------------------------------------------------------------------------
 def handle
    @counter[@counterIndex]=@counter[@counterIndex]+1
    if(@counter[@counterIndex]) >= @parameters.paramsArr[@counterIndex].elementsArr.length
        @counter[@counterIndex]= 0
        @counterIndex= @counterIndex-1
        if(@counterIndex >= 0)
           #puts "%%%%%%%%%%"
            handle
            
        end
        @counterIndex = @parameters.paramsArr.length-1
     end

 end
 def allResult
     @counterIndex = @parameters.paramsArr.length-1
     num=1
     for i in 0...@parameters.paramsArr.length do
        num=num * @parameters.paramsArr[i].elementsArr.length
     end
     for j in 0...num do
        record =Record.new
        for k in 0 ...@parameters.paramsArr.length do
           record.valuesArr[k] = @parameters.paramsArr[k].elementsArr[@counter[k]].value
	   # puts "*****"
          # puts record.valuesArr[k]
        end
        @ucrecords.recordsArr << record
        handle
     end
 end
#add by chuangye end--------------------------------------------------------------------------------------------------

end


class AlgorithmController < ApplicationController

   

  def index
	
 	$matrix_config = MatrixConfig.find(params[:matrix_config_id])
	@matrix_params = $matrix_config.matrix_params
			@costtime
	starttime = Time.now	
			paramsnum = @matrix_params.count
	@width = 100/(paramsnum+2.to_f)
			$manager = Manager.new
	#input parameters	
			i=0
			 while i < paramsnum do   
			       temparameter = BParameter.new (@matrix_params[i].parameter.id)
				vlen = @matrix_params[i].matrix_values.count
		
				for j in 0...vlen.to_i do # input the value for current parameter 
				       element = Element.new @matrix_params[i].matrix_values[j].value.id,0
                                       element.setweight @matrix_params[i].matrix_values[j].weight   #add by chuangye-----
				       temparameter.addElement element
				      end
				     $manager.parameters.paramsArr <<  temparameter  #store the temparameter to @parameters
		  		i+=1
		  	end
			#input parameters end		starttime = Time.now

	puts $matrix_config.has_results.to_s
        puts params[:op].to_s
        puts "~~~~~~~~~%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        if params[:op].to_s =="true"  or  $matrix_config.has_results.to_s=="false" 
            Result.destroy_all(["matrix_config_id=?",params[:matrix_config_id]])
         puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
			#input must not have limit contions
			#set the haslimit 
			  if $matrix_config.limit_pairs.count > 0
				$manager.sethaslimit true
			  else 
				$manager.sethaslimit false
			  end
			 #set the has limit end

			  #set the limit value to function
			 
		  	  $matrix_config.limit_pairs.each do |limit_pair|
				first_value_id = limit_pair.first_value_id
				second_value_id = limit_pair.second_value_id
				firstValue = Value.find(first_value_id)
				secondValue = Value.find(second_value_id)
				firstparameter = Parameter.find(firstValue.parameter_id)
				secondparameter = Parameter.find(secondValue.parameter_id)
				i = 0
				aindex = -1
				while i < $manager.parameters.paramsArr.length  do 		
					if $manager.parameters.paramsArr[i].paramname == firstValue.parameter_id
					 aindex = i
					 break
					end
					i+=1
				end		
				i = 0
				bindex = -1
				while i < $manager.parameters.paramsArr.length  do 		
					if $manager.parameters.paramsArr[i].paramname == secondValue.parameter_id
					 bindex = i
					 break
					end
					i+=1
				end
		

		
				puts "~~~~~~~~~~~~tempair"
				tempair = Pair.new first_value_id.to_i,second_value_id.to_i


		

				i = 0
				while i < $manager.limitvaluesArr.length do 
					tempairs = $manager.limitvaluesArr[i]
					if tempairs.firstParam.to_i == aindex.to_i && tempairs.secondParam.to_i == bindex.to_i
					break
					end
					i+=1
				end
				if i < $manager.limitvaluesArr.length  #yijingcunzai 
					$manager.limitvaluesArr[i].pairsArr << tempair
				else
					tempairs = Pairs.new aindex.to_i,bindex.to_i
					tempairs.pairsArr << tempair
					$manager.limitvaluesArr << tempairs
				end
		
		
			  end
			  

			#input must not have limit contions end
	
			$manager.generatePairs
			$manager.generateNumCases
			
		endtime = Time.now
		@costtime = endtime-starttime	

		#store the results to db


		puts "matrix_config name"
		puts $matrix_config.name

		for i in 0...$manager.records.recordsArr.length do
			for j in 0...$manager.records.recordsArr[i].valuesArr.length do
				result = Result.new
				temp = -1
			
			$matrix_config.matrix_params.each do |matrix_param|
	if	matrix_param.parameter_id == Value.find($manager.parameters.paramsArr[j].elementsArr[$manager.records.recordsArr[i].valuesArr[j]].value).parameter_id
				#puts "matrix_param belong to matrix_config_id"
				#puts matrix_param.matrix_config_id		
				
				#puts "Paramete Name"
				#puts Parameter.find(matrix_param.parameter_id).name

				#puts "parameter Name"
				#puts Parameter.find(matrix_param.parameter_id).name
				
				temp = matrix_param.id
				
				break
				end
			end
			result.matrix_config_id = $matrix_config.id
     			result.matrix_param_id =temp.to_i
			result.value_id = $manager.parameters.paramsArr[j].elementsArr[$manager.records.recordsArr[i].valuesArr[j]].value
			result.has_chosen=true 
			result.sort_id = i
			result.coverage=100
			result.save

			end
		end
		

		#store the results end
		$matrix_config.has_results = true
		$matrix_config.save
                #add by chuangye start
          
 	end
                 allresults = Array.new
	         resultnum = 0
               $manager.records.recordsArr.clear
	       $manager.ucrecords.recordsArr.clear
                puts params[:reset].to_s
                
               if params[:reset].to_s=="true"
                puts "++++++++++++++++++++++++++++++++"
                res = $matrix_config.results.where(["tag = ?",1])
                res.destroy_all
                
                end
		$matrix_config.results.each do  |result|

				allresults << result
				resultnum+=1

		                            end
              
		
		#puts "true results num ="
	     # puts resultnum

		j = 0
		recordsArr = Array.new
	       while j <resultnum do
		record = Record.new
		paramindex=0
		while paramindex<paramsnum do
		result = allresults[j]

		elementindex=0
		while elementindex < $manager.parameters.paramsArr[paramindex].elementsArr.length do
			if $manager.parameters.paramsArr[paramindex].elementsArr[elementindex].value ==result.value_id
			break
			end
			elementindex+=1
		end
		record.valuesArr[paramindex]=result.value_id
		record.setcoverage result.coverage
                record.setTag result.tag
                       
		paramindex+=1
		j+=1
		end
		
		 $manager.records.recordsArr	 << record
               end

                 $manager.allResult
                 
                #get the uc_result,namely, uc_result=all_result -result
                for m in 0...$manager.records.recordsArr.length do
                    for n in 0...$manager.ucrecords.recordsArr.length do
                         flag=0
                         for k in 0 ...paramsnum do
                             if $manager.records.recordsArr[m].valuesArr[k]!= $manager.ucrecords.recordsArr[n].valuesArr[k]
                                   flag=1
                                   break #break out for k
                             end
                         
                         end #for k
                         if flag==0
                           $manager.ucrecords.recordsArr.delete_at(n) 
                           break 
                         end  
          
                    end #for n
                end #for m
                 
                # added by huangym
		# get every ucrecord's weight
		for i in 0...$manager.ucrecords.recordsArr.length do 
			record = $manager.ucrecords.recordsArr[i]
			for j in 0...record.valuesArr.length do 
				@matrix_params.each do |matrix_param|
					matrix_param.matrix_values.each do |matrix_value|
						if matrix_value.value_id == record.valuesArr[j]
							record.setweight matrix_value.weight
						end
					end
				end
			end
		end


                #####  end ####


                puts $manager.records.recordsArr.length
                puts "*********************************************"
                @num=$manager.ucrecords.recordsArr.length
                if @num > 100
                    @num = 100
		    #added by huangym
		    records = $manager.ucrecords.recordsArr
		    for i in 0...100 do 
			for j in i...records.length do 
			     if records[i].weight < records[j].weight
				temp = records[j]
				records[j]=records[i]
				records[i]=temp				
			     end
			end
		    end

 		    # just for test
		   #logger.info("!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@2#######################3")
		   #for i in 0...records.length do 
		   #	logger.info(records[i].weight)
		   #end	

		    # huangym end 

                end
                 
                #add by chuangye end 
	

	##### added by huangym   #######
	haveSelected = Array.new    # store the index of record which has been selected		
	selectedPairs = Array.new   # store the pair has appeared

	#@wei = Array.new  # store the weight of record

        while haveSelected.length < $manager.records.recordsArr.length do

		## get every record's weight
		for i in 0...$manager.records.recordsArr.length do 
			if haveSelected.include? i
				next
			end			
	
			re = $manager.records.recordsArr[i].valuesArr
			we =0
			for j in 0...re.length do 
				logger.info("--------------------------")
				for k in j+1...re.length do 
					if selectedPairs.include?([re[j],re[k]])
						next
					end
					#logger.info("==============================")
					#logger.info(re[j])
					fweight=0
					sweight=0
					@matrix_params.each do |matrix_param|
						matrix_param.matrix_values.each do |matrix_value|
							if matrix_value.value_id == re[j]
								fweight = matrix_value.weight
								#logger.info("11111111111111111")
							end
							if matrix_value.value_id == re[k]
								sweight = matrix_value.weight
							end
						end
					end
					#logger.info("~~~~fweight")
					#logger.info(fweight)
					we += fweight*sweight	
				end
			end	
			$manager.records.recordsArr[i].setwe we
			#logger.info("####################")
			#@wei[i]=we
			#logger.info(we)
			#logger.info("~~~~ we~~")		

		end

		## select the record with max weight
		max =0
		maxIndex=0

		#for i in 0...$manager.records.recordsArr.length do
		#	if max< $manager.records.recordsArr[i].weight 
		#		max = $manager.records.recordsArr[i].weight
		#		maxIndex = i
		#	end
		#end
		#logger.info(@wei.to_s)
		for i in 0...$manager.records.recordsArr.length do
			if haveSelected.include? i
				next
			end
			if max < $manager.records.recordsArr[i].weight
				max = $manager.records.recordsArr[i].weight
				maxIndex=i
			end
		end		
		haveSelected << maxIndex
		re = $manager.records.recordsArr[maxIndex].valuesArr
		for i in 0...re.length do 
			for j in i+1...re.length do 
				if selectedPairs.include?([re[i],re[j]])
					next
				end
				selectedPairs<<[re[i],re[j]]
			end
		end


		logger.info("~~~haveSelected~~~")
		logger.info(haveSelected)
		logger.info(selectedPairs)

	end			
       #########   end  ##########
	   
          respond_to do |format|
		format.html
		format.json {render :json => {'statusCode' => '200', 'navTabId'=>"resulttab",'config_id'=>$matrix_config.id }	}	
	 
     	  end
       
   end
        
 
	#### by huangym #####
	def calculation
		puts "~~~~~~"
		puts @manager.to_s
 			
		# following both are hash
		@selectedvalue_id = params[:value_id]     
		@sbili = params[:sbili]   # coverage

		logger.info(@selectedvalue_id.to_s)
		logger.info(@sbili.to_s)
		logger.info(@selectedvalue_id["2"].to_s)

		@tbili = params[:tbili].to_f      # total coverage
		@count = params[:num].to_i

		for i in 0..@count-1 do        # change the hash key from string to int
			if @sbili[i.to_s]==nil
				@sbili[i]=-1
				@selectedvalue_id[i]=-1
				next
			end
			@sbili[i] = @sbili[i.to_s].to_i
			@sbili.delete(i.to_s)
			@selectedvalue_id[i] = @selectedvalue_id[i.to_s].to_i
			@selectedvalue_id.delete(i.to_s)
		end

		# sort @selectedvalue_id and @sbili , according coverage (@sbili)
		for i in 0..@count-1 do
			for j in i..@count-1 do
				if @sbili[i].to_f < @sbili[j].to_f
					tmp = @sbili[i]
					@sbili[i] = @sbili[j]
					@sbili[j] = tmp
					tmp = @selectedvalue_id[i]
					@selectedvalue_id[i] = @selectedvalue_id[j]
					@selectedvalue_id[j] = tmp
				end
			end
		end

		logger.info(@selectedvalue_id)
		logger.info(@sbili)
		
		for i in 0..@count-1 do
			if @sbili[i]==-1 
				@sbili.delete(i)
				@selectedvalue_id.delete(i)
				@count = i
				break
			end
		end
		logger.info("after delete -1~~~~~")
		logger.info(@selectedvalue_id)
		logger.info(@sbili)


		@recordindex = Array.new   #  @recordindex store the records which have @selectedvalue_id

		@selectedparameter_id = Array.new  # store selected parameter id
		@selectedparameterindex = Array.new   # store selected parameter 

		for i in 0..@count-1 do
			@selectedparameter_id << Value.find(@selectedvalue_id[i]).parameter_id
		end


#		@selectedparameter_id = Value.find(@selectedvalue_id).parameter_id
#		@selectedparameterindex = -1		
		

		@matrix_config = MatrixConfig.find(params[:matrix_config_id])
		group = Group.find($matrix_config.group_id)
		
		@user = User.find(group.user_id)
		@groups = @user.groups

		@matrix_params = $matrix_config.matrix_params

		@costtime
		paramsnum = @matrix_params.count

		@width = 100/(paramsnum+3.to_f)    ####   ??
		@manager = Manager.new
		starttime = Time.now
		i=0
		while i < paramsnum do   
			       temparameter = BParameter.new (@matrix_params[i].parameter.id)
				vlen = @matrix_params[i].matrix_values.count
			
				if @selectedparameter_id.include?(@matrix_params[i].parameter_id)           ####### store the matrix_param id
					@selectedparameterindex << i
				end	
			#	if @matrix_params[i].parameter.id == @selectedparameter_id                  ################ may have many 
			#		@selectedparameterindex = i
			#	end

				for j in 0...vlen.to_i do # input the value for current parameter 
				       element = Element.new @matrix_params[i].matrix_values[j].value.id,0
				       element.setweight @matrix_params[i].matrix_values[j].weight

				       temparameter.addElement element
				 end
				 @manager.parameters.paramsArr <<  temparameter  #store the temparameter to @parameters
		  		 i+=1
		end


	       paramnum = $matrix_config.matrix_params.count
	       allresults = Array.new
	       resultnum = 0
	      
	       $matrix_config.results.each do  |result|
				allresults << result
				resultnum+=1
	       end
		
	       puts "true results num ="
	       puts resultnum

	       j = 0
 	       recordsArr = Array.new
	       while j <resultnum do
		   record = Record.new
		   paramindex=0
		   while paramindex<paramnum do
			result = allresults[j]
			elementindex=0
			while elementindex < @manager.parameters.paramsArr[paramindex].elementsArr.length do
				if @manager.parameters.paramsArr[paramindex].elementsArr[elementindex].value ==result.value_id
					break
				end
				elementindex+=1
			end
			record.valuesArr[paramindex]=result.value_id
                       
			paramindex+=1
			j+=1
		   end
		   @manager.records.recordsArr << record             #  store all records , each include a series of values
		end

		@allArray = Array.new @manager.records.recordsArr.length
		@sarray = Array.new
		@stotal = 0
		@tarray = Array.new
		@ttotal = 0		
		i = 0

		###### calculate weight of every record  #####
		while i < @manager.records.recordsArr.length do
			j=0
			recordweight =0
			while j < @manager.records.recordsArr[i].valuesArr.length do
				@matrix_params.each do |matrix_param|
					matrix_param.matrix_values.each do |matrix_value|
						if matrix_value.value_id == @manager.records.recordsArr[i].valuesArr[j]
							recordweight += matrix_value.weight	
						end
					end
				end
				j+=1
			end
			logger.info("~~~~~~~~~~~~~weight~~~~~")
			logger.info(recordweight)
			@allArray[i] = [i,recordweight,-1]
			i+=1
		end

		############   for every selected value  ######

		logger.info(@selectedvalue_id.length)
		i=0
		while i < @selectedvalue_id.length do 
			logger.info(i)
			j=0
			coverage =0
			k = 0
			logger.info("@recordindex:~~~~~~")
			logger.info(@recordindex.to_s)
			while   k < @recordindex.length do
				#logger.info("@records[k]:~~~~~~~")
				#logger.info($manager.records.recordsArr[@recordindex[k]].to_s)
				if @manager.records.recordsArr[@recordindex[k]].valuesArr.include? @selectedvalue_id[i]
					if @allArray[@recordindex[k]][2]!=-1      # should never be -1
						coverage += @allArray[@recordindex[k]][2]
					end
				end
				k+=1
			end		
			logger.info(coverage)
			coverage = @sbili[i] - coverage
			logger.info("coverage:")
			logger.info(coverage)
			
			totalweight =0
			
			while j< @manager.records.recordsArr.length do
				if @recordindex.include? j
					j+=1
					next
				end
				if @manager.records.recordsArr[j].valuesArr.include? @selectedvalue_id[i]
					@recordindex << j
					totalweight+=@allArray[j][1]
				end
				j+=1
			end

			if coverage <= 0
				#i+=1
				coverage=0
				#next
			end
			
                    

			logger.info("totalweight:")			
			logger.info(totalweight)
			logger.info(@recordindex.to_s)
			logger.info(@manager.records.recordsArr.length)
			j=0
			while j< @manager.records.recordsArr.length do
				#if @allArray[j][2]>0
				#	j+=1
				#	next
				#end
				if @allArray[j][2]==-1				
					if @manager.records.recordsArr[j].valuesArr.include? @selectedvalue_id[i]
						@allArray[j][2] = coverage*@allArray[j][1].to_f/totalweight.to_f					
					end
					logger.info(@allArray[j][2])
					logger.info("-----------------------------")
				end
				j+=1
			end
			
			i+=1

		end


		########## for every record which has no selected value  ##############
		i=0
		coverage=0
		while i < @recordindex.length do
			coverage += @allArray[@recordindex[i]][2]
			i+=1
		end
		coverage = @tbili-coverage

		logger.info("~~~~~~~~~ unselected coverage")
		logger.info(coverage)
		if coverage <=0    
			coverage=0			
		end
		
		totalweight =0
		i=0
		while i< @manager.records.recordsArr.length do 
			if @recordindex.include? i
				i+=1
				next
			end
			totalweight += @allArray[i][1]
			i+=1
		end

		logger.info("=========")
		logger.info(totalweight)

		j=0
		while j< @manager.records.recordsArr.length do
			#if @allArray[j][2]>0
			#	j+=1
			#	next
			#end
			if @allArray[j][2]==-1
				@allArray[j][2] = coverage*@allArray[j][1].to_f/totalweight.to_f
				logger.info("##################")
				logger.info(@allArray[j][2])
				logger.info(j)
			end
			j+=1
		end
=begin
		j=0
		while j< $manager.records.recordsArr.length do
			if @allArray[j][2]<0
				@allArray[j][2]=0
			end
			j+=1
		end

		while i < $manager.records.recordsArr.length do                        ############################## before  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                temweight = -1
				#tem = Array.new 

				if $manager.records.recordsArr[i].valuesArr[@selectedparameterindex].to_i == @selectedvalue_id.to_i #include special value

					$matrix_config.matrix_params.each do |matrix_param|
						matrix_param.matrix_values.each do |matrix_value|
							if matrix_value.value_id ==$manager.records.recordsArr[i].valuesArr[@selectedparameterindex]
								temweight = matrix_value.weight               #################  +=  ?
								break
							end
						end
					end
				
					@allArray[i]=[i,temweight.to_i,0]
					@sarray << i
					@stotal+=temweight.to_i

				else

					j =0
					while j < $manager.records.recordsArr[i].valuesArr.length do
						#temweight += $matrix_config.matrix_params.matrix_values.find_by_value_id($manager.records.recordsArr[i].valuesArr[j]).weight
						$matrix_config.matrix_params.each do |matrix_param|
							matrix_param.matrix_values.each do |matrix_value|
								if matrix_value.value_id ==$manager.records.recordsArr[i].valuesArr[j]
									temweight += matrix_value.weight
									break
								end
							end
						end
						j+=1
					end
					@allArray[i]=[i,temweight.to_i,0]
					@tarray << i
					@ttotal += temweight
				end

				i+=1
		end

					
                ############## ?????  if total > ....*100  ###########
		if @sbili.to_i > @sarray.length*100 
			@sbili = @sarray.length*100
		end

			
		 s = @sbili.to_f/@stotal
		 i = 0
		 while i < @sarray.length do
			@allArray[@sarray[i]][2]=@allArray[@sarray[i]][1]*s
			i+=1
		 end

		#######       ???  ###########
		 if (@tbili.to_f-@sbili.to_f)<0
			@tbili=@tarray.length*100
		 end
		 s = (@tbili.to_f-@sbili.to_f)/@ttotal.to_f                    ### (left coverage)/(sum of left value weight) 
		 i = 0
		 while i < @tarray.length do
			@allArray[@tarray[i]][2]=@allArray[@tarray[i]][1]*s
			i+=1
		 end

		puts "selectedparameterindex"
		puts @selectedparameterindex
=end
		endtime = Time.now
		@costtime = endtime - starttime

=begin
	  respond_to do |format|
		
	#		format.html { redirect_to :action => 'index', :matrix_config_id => $matrix_config.id}
	#		navTabName ='#{group.name + $matrix_config.name}'
			format.json {render :json=>{ 'statusCode' =>'200', 'message'=>' Calculation finished!','navTabID' => 'calculation', 'rel' =>'forward' , 'forwardUrl'=>'calculation' }}
		     
	#		format.html { render action: "calculation",layout:"mainlayout",:target=>"navTab",:rel=>"calculation" }
     
		     
	  end
=end	

	end
  
	def calculate
		@matrix_config = MatrixConfig.find(params[:matrix_config_id])
                    
	end 


	############# add by huangym
        def saveCoverage
		logger.info(params[:coverage].to_s)
		co = params[:coverage]    # co is a hash , key is the record index, value is the coverage, both are string
		co.each_key do |key|
			$manager.records.recordsArr[key.to_i].setcoverage co[key].to_f     # add coverage to the record
			results = Result.find(:all,:conditions=>["sort_id=? and matrix_config_id=?" ,key.to_i, $matrix_config.id])
			results.each do |result|
				result.update_attribute('coverage',co[key].to_f)
			end
		end

		respond_to do |format|
	                format.json{render :json=>{ 'statusCode' =>'200', 'message'=>'Save succeed!','navTabID' => 'resulttab', 'rel' =>'resulttab','config_id'=> $matrix_config.id,'url'=>"/algorithm/index" }}
		end

        end
	############ end
	


      #add by chuangeye start
       def addrecords
		hash = params[:index]
		@index= Array.new
		i=0
		hash.each_key do |key|
                        if hash[key].to_i !=-1
			  @index[i]=hash[key].to_i
			  i+=1
                        end
                   
		end
		puts "~~~~~~~~~~~~~~~result.length ~~~~~~~~~`"
		before=Result.find(:all)
		puts before.count
		logger.info(@index)
puts "~~~~~~~~~~~~~~~result.length ~~~~~~~~~`"
puts @index
                sortid=$manager.records.recordsArr.length
                for j in 0...@index.length do
                     for k in 0...$manager.ucrecords.recordsArr[0].valuesArr.length do
				result = Result.new
				temp = -1
                        puts "%%%______________________________________________________________%%"
			#puts $manager.ucrecords.recordsArr[@index[j]].valuesArr
			$matrix_config.matrix_params.each do |matrix_param|
			if	matrix_param.parameter_id == Value.find($manager.ucrecords.recordsArr[@index[j]].valuesArr[k]).parameter_id
				
				temp = matrix_param.id
				
				break
				end
			end
                     
			result.matrix_config_id = $matrix_config.id
     			result.matrix_param_id =temp.to_i
			result.value_id = $manager.ucrecords.recordsArr[@index[j]].valuesArr[k]
			result.has_chosen=true 
			result.sort_id = sortid+j
                        result.tag=1
			result.save

		end
               $manager.ucrecords.recordsArr.delete_at(@index[j])
             end
             @index.clear
		puts "~~~~~~~~~~~~~~~result.length after~~~~~~~~~`"
		after=Result.find(:all)
		puts after.count

		respond_to do |format|
	                format.json{render :json=>{ 'statusCode' =>'200', 'message'=>'Add records succeed!','navTabID' => 'resulttab', 'rel' =>'resulttab','config_id'=> $matrix_config.id,'url'=>"/algorithm/index" }}
		end

	end
      #add by chuangye end


end
