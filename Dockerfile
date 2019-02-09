FROM centos:latest

ENV PATH=/root/.cargo/bin:$PATH \
    USER=root

RUN yum install -y git gcc wget vim cmake make zlib-devel; \
    container_arch="$(uname -m)"; \
    case "${container_arch}" in \
        x86_64) rustArch='x86_64-unknown-linux-gnu'; rustupSha256='c9837990bce0faab4f6f52604311a19bb8d2cde989bea6a7b605c8e526db6f02' ;; \
        i386) rustArch='i686-unknown-linux-gnu'; rustupSha256='27e6109c7b537b92a6c2d45ac941d959606ca26ec501d86085d651892a55d849' ;; \
        *) echo >&2 "unsupported architecture: ${container_arch}"; exit 1 ;; \
    esac; \
    wget https://static.rust-lang.org/rustup/archive/1.11.0/${rustArch}/rustup-init; \
    echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --default-toolchain 1.25.0; \
    rm ./rustup-init; \
    mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim; \
    echo "execute pathogen#infect()" > ~/.vimrc; \
    echo "syntax on" >> ~/.vimrc; \
    echo "filetype plugin indent on" >> ~/.vimrc; \
    git clone --depth=1 https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim; \
    pushd /etc/yum.repos.d/; \
    wget https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo; \
    popd; \
    yum install -y fish; \
    chsh -s /usr/bin/fish; \
    pushd /opt; \
    git clone https://github.com/ogham/exa.git; \
    pushd ./exa; \
    make install; \
    mkdir ~/code

COPY ls.fish /root/.config/fish/functions/ls.fish
