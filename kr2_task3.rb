mutex = Mutex.new
cv = ConditionVariable.new
turn = 1

thread1 = Thread.new do
  mutex.synchronize do
    1.upto(10) do |i|
      while turn != 1
        cv.wait(mutex)
      end
      puts "Thread 1: #{i}"
      turn = 2
      cv.signal
    end
  end
end

thread2 = Thread.new do
  mutex.synchronize do
    1.upto(10) do |i|
      while turn != 2
        cv.wait(mutex)
      end
      puts "Thread 2: #{i}"
      turn = 1
      cv.signal
    end
  end
end

thread1.join
thread2.join