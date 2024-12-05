#ifndef __LOG__
# define __LOG__

# if defined(VERBOSE) || defined(LOG)
#  include <iostream>
#  define LOG(...) std::cout << msg << std::endl;
# else
#  define LOG(...)
# endif 

#endif /* __LOG__ */
