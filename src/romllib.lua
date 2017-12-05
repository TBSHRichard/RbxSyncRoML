local a,b,c,d,e,f,g,h,i,j;do local k;local l=f;local m={ObjectName=function(self)return self.__class.__name end,Create=function(self)end,CreateProperties=function(self)return{}end,PropertyUpdateOrder=function(self)return{}end,UpdateProperty=function(self,n,o,p)end,Refresh=function(self)local q=self:PropertyUpdateOrder()if#q>0 then for r=1,#q do local o=q[r]if self._properties[o]~=nil then self:UpdateProperty(self._robloxObject,o,self._properties[o])end end else for o,s in pairs(self._properties)do self:UpdateProperty(self._robloxObject,o,s)end end end,StyleObject=function(self,t)local q=self:PropertyUpdateOrder()if#q>0 then for r=1,#q do local o=q[r]if t[o]~=nil then self:UpdateProperty(self._robloxObject,o,t[o])end end else for o,s in pairs(t)do self:UpdateProperty(self._robloxObject,o,s)end end end}m.__index=m;setmetatable(m,l.__base)k=setmetatable({__init=function(self,u,v,w)k.__parent.__init(self,u,self:Create(),v,w)return self:SetProperties(self:CreateProperties())end,__base=m,__name="CustomObject",__parent=l},{__index=function(x,o)local y=rawget(m,o)if y==nil then local z=rawget(x,"__parent")if z then return z[o]end else return y end end,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;if l.__inherited then l.__inherited(l,k)end;a=k end;do local k;local m={Build=function(self,o,B)local C={}C.FilterProperty=B.FilterProperty or function(o,p,D,E)return D(p)end;do local F;local l=a;local G={Create=B.Create,UpdateProperty=B.UpdateProperty}G.__index=G;setmetatable(G,l.__base)F=setmetatable({__init=function(self,u,v,w)self.__class.__name=o;if B.CreateProperties then self.CreateProperties=B.CreateProperties end;if B.AllowsChildren then self.AllowsChildren=B.AllowsChildren end;if B.PropertyUpdateOrder then self.PropertyUpdateOrder=B.PropertyUpdateOrder end;return F.__parent.__init(self,u,v,w)end,__base=G,__name="customObject",__parent=l},{__index=function(x,o)local y=rawget(G,o)if y==nil then local z=rawget(x,"__parent")if z then return z[o]end else return y end end,__call=function(x,...)local A=setmetatable({},G)x.__init(A,...)return A end})G.__class=F;if l.__inherited then l.__inherited(l,F)end;C.customObject=F end;self._customObjects[o]=C end,HasObject=function(self,o)return self._customObjects[o]~=nil end,GetObject=function(self,o)return self._customObjects[o].customObject end,FilterProperty=function(self,H,I,p,D,E)return self._customObjects[H].FilterProperty(I,p,D,E)end}m.__index=m;k=setmetatable({__init=function(self)self._customObjects={}self:Build("SpriteSheet",i)if game then local J=game:GetService("ServerScriptService").com.blacksheepherd.customobject.user:GetChildren()for r=1,#J do local K=J[r]self:Build(K.name,require(K))end end end,__base=m,__name="CustomObjectBuilder"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;local self=k;self.Instance=function()if not self.__class._instance then self.__class._instance=b()end;return self.__class._instance end;b=k end;local L;L=function(o)return b.Instance():HasObject(o)end;local M;M=function(o,u,v,w)return b.Instance():GetObject(o)(u,v,w)end;local N;N=function(H,I,p,D,E)return b.Instance():FilterProperty(H,I,p,D,E)end;local O;do local k;local m={notify=function(self,...)return self:_observer(...)end,disonnect=function(self)return self._event:removeObserver(self._id)end}m.__index=m;k=setmetatable({__init=function(self,P,Q,R)self._id=P;self._observer=Q;self._event=R end,__base=m,__name="EventConnection"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;O=k end;do local k;local m={connect=function(self,Q)local S=O(self._nextId,Q,self)self._observers[tostring(self._nextId)]=S;self._nextId=self._nextId+1;return S end,notifyObservers=function(self,...)for T,Q in pairs(self._observers)do Q:notify(...)end end,removeObserver=function(self,P)self._observers[tostring(self._nextId)]=nil end}m.__index=m;k=setmetatable({__init=function(self)self._observers={}self._nextId=1 end,__base=m,__name="Event"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;c=k end;do local k;local m={pairs=function(self)return pairs(self._t)end,Length=function(self)return self:__len()end,__newindex=function(self,U,p)if self._t[U]==nil then self._length=self._length+1 elseif p==nil then self._length=self._length-1 end;self._t[U]=p end,__len=function(self)return self._length end}m.__index=m;k=setmetatable({__init=function(self,B)rawset(self,"_t",{})rawset(self,"_length",0)for U,p in pairs(B)do self[U]=p end;local V=getmetatable(self)local W=V.__index;V.__index=function(self,U)do local p=rawget(rawget(self,"_t"),U)if p then return p else if type(W)=="function"then return W(self,U)else return W[U]end end end end end,__base=m,__name="HashMap"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;d=k end;do local k;local m={GetVar=function(self,X)return self._vars[X]end,Find=function(self,Y)return self._rootObject:Find(Y)end,AddChild=function(self,Z)self._children[Z:GetId()]=Z;if not(self._ross==nil)then return self._ross:StyleObject(Z)end end,RemoveChild=function(self,Z)self._children[Z:GetId()]=nil end,SetStyleSheet=function(self,_)self._ross=_;for T,Z in self._children:pairs()do self._ross:StyleObject(Z)end end,_create=function(self,z,a0)end}m.__index=m;k=setmetatable({__init=function(self,z,a0,_)self._objectIds={}self._vars={}self._ross=_;self._children=d({})return self:_create(z,a0 or{})end,__base=m,__name="RomlDoc"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;e=k end;local a1=1;do local k;local m={SetParent=function(self,z)self._parent=z;if z then self._robloxObject.Parent=z:GetRobloxObject()end end,GetRobloxObject=function(self)return self._robloxObject end,ObjectName=function(self)return self._robloxObject.ClassName end,Refresh=function(self)for o,s in pairs(self._properties)do local a2=self._propertyFilters[o]if a2 then a2(s,self._robloxObject)else self._robloxObject[o]=s end end end,StyleObject=function(self,t)for o,s in pairs(t)do local a2=self._propertyFilters[o]if a2 then a2(s,self._robloxObject)else self._robloxObject[o]=s end end end,AddChild=function(self,a3)if self:AllowsChildren()then a3:SetParent(self)self._children[a3:GetId()]=a3;return a3 else return error("RomlObject '"..tostring(self.__class.__name).."' does not allow children objects.")end end,SetProperties=function(self,t)for o,p in pairs(t)do self._properties[o]=p end end,SetClasses=function(self,w)self._classes=w end,RemoveAllChildren=function(self)for T,a3 in self._children:pairs()do self._romlDoc:RemoveChild(a3)a3:RemoveAllChildren()a3._robloxObject:Destroy()end;self._children={}end,GetId=function(self)return self._id end,GetObjectId=function(self)return self._objectId end,GetClasses=function(self)return self._classes end,RemoveChild=function(self,a3)a3:SetParent(nil)self._children[a3:GetId()]=nil end,HasClass=function(self,a4)local J=self._classes;for r=1,#J do local o=J[r]if o==a4 then return true end end;return false end,MatchesSelector=function(self,a5)local Y=a5:Pop()local a6=false;if Y.object~=nil then a6=Y.object==self:ObjectName()if Y.class~=nil then a6=a6 and self:HasClass(Y.class)elseif Y.id~=nil then a6=a6 and Y.id==self._objectId end else if Y.class~=nil then a6=self:HasClass(Y.class)else a6=Y.id==self._objectId end end;if a6 then if not a5:IsEmpty()then return self._parent:MatchesSelector(a5)else return true end else return false end end,AllowsChildren=function(self)return true end,Find=function(self,Y)end}m.__index=m;k=setmetatable({__init=function(self,u,a7,v,w)if w==nil then w={}end;self._romlDoc=u;self._id=a1;a1=a1+1;self._properties={}self._propertyFilters={}self._objectId=v;if type(a7)=="string"then a7=Instance.new(a7)end;self._robloxObject=a7;self._classes=w;self._children=d({})end,__base=m,__name="RomlObject"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;f=k end;do local k;local m={SetValue=function(self,p)local a8=self._value;rawset(self,"_value",p)return self.Changed:notifyObservers(a8,p)end,GetValue=function(self)return self._value end,__newindex=function(self,U,p)if type(self._value)=="table"or type(self._value)=="userdata"and self._value.ClassName then local a8=self._value[U]self._value[U]=p;return self.Changed:notifyObservers(U,a8,p)end end,Changed=nil}m.__index=m;k=setmetatable({__init=function(self,p)rawset(self,"_value",p)return rawset(self,"Changed",c())end,__base=m,__name="RomlVar"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;g=k end;do local k;local m={StyleObject=function(self,Z)local H=Z:ObjectName()self:_styleWithTable(Z,self._objects[H])local J=Z:GetClasses()for r=1,#J do local a9=J[r]self:_styleWithTable(Z,self._classes["."..tostring(a9)])self:_styleWithTable(Z,self._classes[tostring(H).."."..tostring(a9)])end;local v=Z:GetObjectId()if not(v==nil)then self:_styleWithTable(Z,self._ids["#"..tostring(v)])self:_styleWithTable(Z,self._ids[tostring(H).."#"..tostring(v)])end;return Z:Refresh()end,_styleWithTable=function(self,Z,B)if B==nil then B={}end;for r=1,#B do local aa=B[r]if Z:MatchesSelector(aa.selector:Clone())then Z:StyleObject(aa.properties)end end end,_setupObjects=function(self)return{}end,_setupClasses=function(self)return{}end,_setupIds=function(self)return{}end}m.__index=m;k=setmetatable({__init=function(self)self._objects=self:_setupObjects()self._classes=self:_setupClasses()self._ids=self:_setupIds()end,__base=m,__name="RossDoc"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;h=k end;i={Create=function(self)local ab=Instance.new("Frame")ab.ClipsDescendants=true;ab.Name="SpriteSheetFrame"ab.BackgroundTransparency=1;ab.BorderSizePixel=0;local ac=Instance.new("ImageLabel",ab)ac.Name="SpriteSheet"ac.Size=UDim2.new(0,256,0,256)ac.BackgroundTransparency=1;ac.BorderSizePixel=0;return ab end,CreateProperties=function(self)return{}end,PropertyUpdateOrder=function(self)return{"Name","Position","SpriteSheet","Size","Index"}end,FilterProperty=function(o,p,D,E)local ad=o;if"Position"==ad then return E.UDim2Filter(p)elseif"Size"==ad then return E.Vector2Filter(p)else return D(p)end end,UpdateProperty=function(self,ab,o,p)local ad=o;if"Name"==ad then ab.Name=p elseif"Position"==ad then ab.Position=p elseif"SpriteSheet"==ad then ab:FindFirstChild("SpriteSheet").Image=p elseif"Size"==ad then ab.Size=UDim2.new(0,p.x,0,p.y)elseif"Index"==ad then local ae=math.floor(256/ab.Size.X.Offset)local af=p%ae;local ag=math.floor(p/ae)ab:FindFirstChild("SpriteSheet").Position=UDim2.new(0,-af*ab.Size.X.Offset,0,-ag*ab.Size.Y.Offset)end end,AllowsChildren=function(self)return false end}do local k;local m={Push=function(self,aa)return table.insert(self,aa)end,Pop=function(self)return table.remove(self)end,Peek=function(self)return self[#self]end,IsEmpty=function(self)return#self==0 end,Clone=function(self)return j(self)end}m.__index=m;k=setmetatable({__init=function(self,ah)if ah==nil then ah={}end;for r=1,#ah do local aa=ah[r]table.insert(self,1,aa)end end,__base=m,__name="Stack"},{__index=m,__call=function(x,...)local A=setmetatable({},m)x.__init(A,...)return A end})m.__class=k;j=k end;return{CustomObject=a,CustomObjectBuilder=b,Event=c,HashMap=d,RomlDoc=e,RomlObject=f,RomlVar=g,RossDoc=h,SpriteSheet=i,Stack=j}
