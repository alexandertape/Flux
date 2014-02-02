#!/usr/bin/python

#import the necessary libraries

import thread
import time
import csnd6
import random

#set up necessary variables for script execution
i = 0
switch = 1

#create an instance of Csound, compiling the master .csd
#and opening it in a performance thread so it can begin receiving
#performance input

cs = csnd6.Csound()
res = cs.Compile("Orchestra.csd")
perf = csnd6.CsoundPerformanceThread(cs)
perf.Play()

# Define a function for the thread
def print_time( threadName, delay):
   count = 0
   while count < 5:
      time.sleep(delay)
      count += 1
      print "%s: %s" % ( threadName, time.ctime(time.time()) )

###########################Instrument Functions#############################
def fm(t, dum):
	while(1):	
		if(switch==1):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.6,0.8)
			notes =[60,62,64,67,69,71]
			pitch = random.choice(notes) + random.choice([0,12])
			pan = random.uniform(0.0,1.0)
			if logic < 3:
				perf.InputMessage("i1 0 1 %g %g %g\n" % (amp, pitch, pan))
			time.sleep(t)
		else:
			pass

def guitar(t, dum):
	while(1):
		if(switch==1):
			amp = random.uniform(0.6, 1.0)	
			logic = random.choice([0,1,2,3,4])	
			bb1 = random.choice([1,2,4,8])
			bb2 = random.choice([1,2,4,8])
			bb3 = random.choice([1,2,4,8])
			bb4 = random.choice([1,2,4,8])
			bb5 = random.choice([1,2,4,8])
			foo = [8, 9, 10, 11, 12, 13]
			chord = random.choice(foo)
			if logic < 3:
				perf.InputMessage("i2 0 2 %g %g %g %g %g %g %d \n" % (amp, bb1, bb2, bb3, bb4, bb5,chord))
			time.sleep(t)
		else:
			pass

def pluck(t, dum):
	while(1):
		if(switch==1):
			logic = random.choice([0,1,2,3,4])	
			strike = random.uniform(0.2,0.8)
			amp = random.uniform(0.1,0.3)
			notes =[60,62,64,67,69,71]
			pitch = random.choice(notes) + random.choice([-12,0,12])
			pick = random.uniform(0.1,0.9)
			kref = random.uniform(0.3,0.7)
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.2,0.8)
			if logic > 0:
				perf.InputMessage("i3 0 1 %g %g %g %g %g %g %g \n" % (strike, amp, pitch, pick, kref, pan, rvb))
			time.sleep(t)
		else:
			pass

def perc(t, dum):
	while(1):
		if(switch==1):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.2,0.4)
			pitch = random.choice([-2,-1,1,2])
			fn = random.randint(1,7)
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.2, 0.7)
			if logic > 2:
				perf.InputMessage("i6 0 1 %g %g %d %g %g \n" % (amp, pitch, fn, pan, rvb))
			time.sleep(t)
		else:
			pass

def drum1(t, dum):
	while(1):
		if(switch==2):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.2,0.4)
			pitch = random.choice([-2,-1,1,2])
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.5, 0.8)
			if logic > 2:
				perf.InputMessage("i11 0 1 %g %g %g %g \n" % (amp, pitch, pan, rvb))
			time.sleep(t)
		else:
			pass

def drum2(t, dum):
	while(1):
		if(switch==2):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.2,0.4)
			pitch = random.choice([-2,-1,1,2])
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.5, 0.8)
			if logic > 2:
				perf.InputMessage("i12 0 1 %g %g %g %g \n" % (amp, pitch, pan, rvb))
			time.sleep(t)
		else:
			pass

def drum3(t, dum):
	while(1):
		if(switch==2):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.2,0.4)
			pitch = random.choice([-2,-1,1,2])
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.5, 0.8)
			if logic > 2:
				perf.InputMessage("i13 0 1 %g %g %g %g \n" % (amp, pitch, pan, rvb))
			time.sleep(t)
		else:
			pass

def drum4(t, dum):
	while(1):
		if(switch==2):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.2,0.4)
			pitch = random.choice([-2,-1,1,2])
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.5, 0.8)
			if logic > 2:
				perf.InputMessage("i14 0 1 %g %g %g %g \n" % (amp, pitch, pan, rvb))
			time.sleep(t)
		else:
			pass

def dirtyfm(t, dum):
	while(1):	
		if(switch==3):
			logic = random.choice([0,1,2,3,4])	
			amp = random.uniform(0.6,0.8)
			notes =[60,62,64,67,69,71]
			pitch = random.choice(notes) + random.choice([0,12])
			pan = random.uniform(0.0,1.0)
			if logic < 3:
				perf.InputMessage("i21 0 1 %g %g %g\n" % (amp, pitch, pan))
			time.sleep(t)
		else:
			pass

def dirtyguitar(t, dum):
	while(1):
		if(switch==3):
			amp = random.uniform(0.6, 1.0)	
			logic = random.choice([0,1,2,3,4])	
			bb1 = random.choice([1,2,4,8])
			bb2 = random.choice([1,2,4,8])
			bb3 = random.choice([1,2,4,8])
			bb4 = random.choice([1,2,4,8])
			bb5 = random.choice([1,2,4,8])
			foo = [8, 9, 10, 11, 12, 13]
			chord = random.choice(foo)
			if logic < 3:
				perf.InputMessage("i22 0 2 %g %g %g %g %g %g %d \n" % (amp, bb1, bb2, bb3, bb4, bb5,chord))
			time.sleep(t)
		else:
			pass

def dirtypluck(t, dum):
	while(1):
		if(switch==3):
			logic = random.choice([0,1,2,3,4])	
			strike = random.uniform(0.2,0.8)
			amp = random.uniform(0.1,0.3)
			notes =[60,62,64,67,69,71]
			pitch = random.choice(notes) + random.choice([-12,0,12])
			pick = random.uniform(0.1,0.9)
			kref = random.uniform(0.3,0.7)
			pan = random.uniform(0.0,1.0)
			rvb = random.uniform(0.2,0.8)
			if logic > 0:
				perf.InputMessage("i23 0 1 %g %g %g %g %g %g %g \n" % (strike, amp, pitch, pick, kref, pan, rvb))
			time.sleep(t)
		else:
			pass



# Create threads for mvt 1
thread.start_new_thread( fm, (2, 2) )
time.sleep(16.0)
thread.start_new_thread( pluck, (4, 2) )
time.sleep(8.0)
thread.start_new_thread( guitar, (8,2))
time.sleep(8.0)

time.sleep(24.0)

switch = 2

time.sleep(8.0)
perf.InputMessage("i20 0 1 \n")

thread.start_new_thread(drum1, (1.25, 2))
time.sleep(8.0)
thread.start_new_thread(drum2, (1.5, 2))
time.sleep(8.0)
thread.start_new_thread(drum3, (1.5, 2))
time.sleep(8.0)
thread.start_new_thread(drum4, (1.25, 2))

time.sleep(16)

switch = 3
perf.InputMessage("i20 0 1 \n")
perf.InputMessage("i19 0 1 \n")
time.sleep(8.0)

thread.start_new_thread(dirtyfm, (2, 2))
time.sleep(8.0)
thread.start_new_thread(dirtypluck, (4,2))
time.sleep(8.0)
thread.start_new_thread(dirtyguitar,(4,2))
time.sleep(32.0)


switch = 0
time.sleep(16.0)

perf.Stop()



#except:
#   print "Error: unable to start thread"
#
#while 1:
#   pass
