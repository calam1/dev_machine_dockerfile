FROM ubuntu:17.10

MAINTAINER chris.lam@oracle.com

ENV http_proxy=http://rmdc-proxy.oracle.com:80/
ENV HTTP_PROXY=http://rmdc-proxy.oracle.com:80/
ENV https_proxy=http://rmdc-proxy.oracle.com:80/
ENV HTTPS_PROXY=http://rmdc-proxy.oracle.com:80/
ENV no_proxy=us.oracle.com,uln-internal.oracle.com,cedepot.oraclecorp.com

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

# Package installation
RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install \
         vim \
         git \
         tree \
         zsh \
         tmux \
         wget \
         curl \
         htop \
	 locales \
	 software-properties-common \
	 python-software-properties \
	 python-dev \
         python-pip \
	 python3-dev \
	 python3-pip \
 	 autogen \
	 automake \
	 libevent-dev \
	 libncurses5-dev \
	 silversearcher-ag


# Generally a good idea to have these, extensions sometimes need them
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# zsh install and set up
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git /root/.zprezto
COPY ./.zshrc /root/
WORKDIR /root
RUN pwd
RUN /bin/zsh -c "source .zshrc"
RUN chsh -s /bin/zsh
RUN ln -s "/root/.zprezto/runcoms/zpreztorc" "/root/.zpreztorc"
RUN ln -s "/root/.zprezto/runcoms/zlogin" "/root/.zlogin"
RUN ln -s "/root/.zprezto/runcoms/zlogout" "/root/.zlogout"
RUN ln -s "/root/.zprezto/runcoms/zprofile" "/root/.zprofile"
RUN ln -s "/root/.zprezto/runcoms/zshenv" "/root/.zshenv"
RUN sed -ri "s/'prompt'/'prompt' 'syntax-highlighting' 'history-substring-search' 'git'/g" /root/.zpreztorc
RUN zsh
CMD ["zsh"]

# Install tmux
WORKDIR /usr/local/src
RUN wget https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz
RUN tar xzvf tmux-2.5.tar.gz
WORKDIR /usr/local/src/tmux-2.5
RUN ./configure
RUN make 
RUN make install
RUN rm -rf /usr/local/src/tmux*
# copy tmux conf to home dir
COPY ./.tmux.conf /root/

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

# Install neovim
RUN apt-get update && \
    apt-get install -y \
	libtool \
	autoconf \
	automake \
	cmake \
	libncurses5-dev \
	g++ \
	pkg-config \
	unzip \
	git \ 
	curl \
	libtool-bin

RUN git clone https://github.com/neovim/neovim.git nvim && \
    cd nvim && \
    make && make install && \
    cd ../ && rm -rf nvim

# this will be first screen you see if you set this
#ENTRYPOINT nvim

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ADD nvim /root/.config/nvim

## Install neovim Modules
RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1
RUN nvim -i NONE -c UpdateRemotePlugins -c quitall > /dev/null 2>&1

WORKDIR /root
