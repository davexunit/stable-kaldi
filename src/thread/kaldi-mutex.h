// thread/kaldi-mutex.h

// Copyright 2012  Karel Vesely (Brno University of Technology)

// See ../../COPYING for clarification regarding multiple authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
// THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
// WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
// MERCHANTABLITY OR NON-INFRINGEMENT.
// See the Apache 2 License for the specific language governing permissions and
// limitations under the License.


#ifndef KALDI_THREAD_KALDI_MUTEX_H_
#define KALDI_THREAD_KALDI_MUTEX_H_ 1

#ifndef NO_PTHREAD
#include <pthread.h>

namespace kaldi {

/**
 * This class encapsulates mutex to ensure
 * exclusive access to some critical section
 * which manipulates shared resources.
 *
 * Note.: The mutex MUST BE UNLOCKED from
 * the SAME THREAD which has locked it!
 */
class Mutex {
 public:
  Mutex();
  ~Mutex();

  void Lock();

  /**
   * Try to lock the mutex without waiting for it.
   * Returns: true when lock successfull,
   *         false when mutex was already locked
   */
  bool TryLock();

  void Unlock();

 private:
  pthread_mutex_t mutex_;
  KALDI_DISALLOW_COPY_AND_ASSIGN(Mutex);
};
} // namespace kaldi
#else // no pthread
namespace kaldi {

/**
 * This class encapsulates mutex to ensure
 * exclusive access to some critical section
 * which manipulates shared resources.
 *
 * Note.: The mutex MUST BE UNLOCKED from
 * the SAME THREAD which has locked it!
 */
class Mutex {
 public:
  Mutex()
  {
    throw std::runtime_error("Mutex, cannot be used when NO_PTHREAD macro defined.");
  }
  ~Mutex() {}

  void Lock()
  {
      throw std::runtime_error("Mutex cannot be used when NO_PTHREAD macro defined");
  }

  /**
   * Try to lock the mutex without waiting for it.
   * Returns: true when lock successfull,
   *         false when mutex was already locked
   */
  bool TryLock()
  {
      throw std::runtime_error("Mutex cannot be used when NO_PTHREAD macro defined");
  }

  void Unlock()
  {
      throw std::runtime_error("Mutex cannot be used when NO_PTHREAD macro defined");
  }

};

} // namespace kaldi
#endif


#endif // KALDI_THREAD_KALDI_MUTEX_H_
