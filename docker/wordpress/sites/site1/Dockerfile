FROM wordpress:php7.4-apache
#FROM wordpress:6.7-php8.1-apache
# Install necessary packages
RUN apt-get update && \
    apt-get install -y vim zsh git zip unzip wget jq fzf && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install Zsh and oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc

# Set Zsh as the default shell
# RUN chsh -s $(which zsh)

# Create ~/.wp directory and copy custom scripts
# RUN mkdir -p ~/.wp
# COPY .wp/*.sh /root/.wp/

# Automatically source scripts from ~/.wp/ in Zsh

# Copy your custom PHP configuration file
COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Copy your application code
COPY . /var/www/html


# Copy your entrypoint script into the container
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make sure it's executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set it as the entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]


WORKDIR /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
