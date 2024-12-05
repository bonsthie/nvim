#ifndef __OUI__
# define __OUI__

class oui {
	public:
	oui(const oui &ref);
	oui(void);
	~oui(void);

	oui &operator=(oui const &src);
};

#endif /* __OUI__ */