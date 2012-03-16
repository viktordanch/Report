class User < ActiveRecord::Base
 has_many :records
end
 
class Record < ActiveRecord::Base
  belongs_to :user
end

class Project < ActiveRecord::Base
   
end

 
def registration(var1, var2, var3, params)
  if (var1==var2)&&!(User.find_by_login(var3))&&!(params["name"]=="")&&!(params["email"]=="")&&!(params["email"]=="")&&!(params["position"]=="")&&!(params["login"]=="login")
   user=User.new(
     :name=>params["name"],
     :email=>params["email"],
     :position=>params["position"],
     :login=>params["login"],
     :password=>params["password"]
    )
   user.save
   redirect '/'
  else
   "It's login alredy exits or your password and confirm rassword are not aqual"
  end
end

def enter(n1,n2)
  pos=User.find(:first, :conditions => {:login=>n1, :password=>n2})
      
  if (pos)
   params["id"]=pos.id 
   session["user"] = pos.id
   if !(pos.records.empty?)
    lastrecord=pos.records.find(:first, :order =>"id DESC")    
    params["month"]=lastrecord.month
    params["date"]=lastrecord.date
    params["year"]=lastrecord.year
   end           
  erb :work   
  elsif (n1.to_s=="login")&&(n2.to_i==1234) 
    erb :registration
  else
   "bed login or password"
  end                                          
end

def saveproject(params)
 if (!(params["tools"]==""))&&(!(params["platform"]=="")) &&(!(params["description"]==""))&&(!(params["title"]==""))
  project=Project.new(
     :title=>params["title"],
     :description=>params["description"],
     :platform=>params["platform"],
     :tools=>params["tools"]     
    )
   project.save
   end
   erb :work
end

def saverecord(params)
 if !(params["timework"]=="")&&!(params["activity"]=="")&&(params["project"])
 record=Record.new(   
      :timename=>params["timename"],
      :user_id=>params["id"],      
      :timework=>params["timework"],
     :project=>params["project"],
     :activity=>params["activity"],
     :month=>params["month"],
     :date=>params["date"],
    :year=>params["year"]  
    )
  record.save
  end   
  erb :work
end

def newdate(params) 
 user=User.find_by_id(params["id"]) 
 newdate=user.records.find(:first, :conditions=>{:month=>params["month"], 
                                  :date=>params["date"], :year=>params["year"]})
  if !(newdate)
    params["id"]=params["id"]      
    params["month"]=params["month"]
    params["date"]=params["date"]
    params["year"]=params["year"]  
  else
    params["id"]=user.id      
    params["month"]=newdate.month
    params["date"]=newdate.date
    params["year"]=newdate.year 
  end 
   erb :work
end
def funcdelete(params)
   user=User.find_by_id(params["id"])
   userrecord=user.records.find(:first, :conditions=>{:project=>params["project"],
                                                :activity=>params["activity"],
                                                :timework=>params["timework"],
                                                :date=>params["date"],
                                                :month=>params["month"],
                                                :year=>params["year"]
   })
  userrecord.destroy 
  erb :work 
end
