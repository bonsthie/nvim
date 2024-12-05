#ifndef __OK__
# define __OK__

class ok {
	public:
	ok(const ok &ref);
	ok(void);
	~ok(void);

	ok &operator=(ok const &src);
};

#endif /* __OK__ */