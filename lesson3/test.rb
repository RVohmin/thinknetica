
#irb -r ./train.rb -r ./station.rb -r /route.rb


train1 = Train.new(111)
train2 = Train.new(222)
train3 = Train.new(333)

A = Station.new('A')
b = Station.new('b')
c = Station.new('c')
d = Station.new('d')
Z = Station.new('Z')


route = Route.new(A, Z)
route.set_way_station(b)
route.set_way_station(c)
route.set_way_station(d)
route.set_way_station(d)
route.delete_station(d)
route.stations

train1.get_route(route)
train1.go_next
train1.go_next
c.trains

train2.get_route(route)
train2.go_next
train2.go_next
train2.go_prev

train3.get_route(route)
train3.go_next
train3.go_next
train3.go_prev
train3.go_prev
A.trains

