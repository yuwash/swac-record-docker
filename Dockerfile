FROM ubuntu:bionic
LABEL maintainer "Yushin Washio <yuwash at yandex dot com>"

RUN set -ex \
	&& apt-get update && apt-get install -y --no-install-recommends \
		wget \
		libqt4-dev \
		# libportaudio-dev in older repositories
		portaudio19-dev \
		libflac++-dev \
		# required for build
		g++ \
		# following: to mark run-time dependencies manually installed
		libqtgui4 \
		libportaudiocpp0 \
		libflac++6v5 \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget -nv -O swac-record-0.4.tar.gz http://zmoo.fr/download/swac-record-0.4.tar.gz \
	&& tar -xzf swac-record-0.4.tar.gz \
	&& rm swac-record-0.4.tar.gz \
	# folder name not necessarily corresponds to archive name
	&& cd swac-record-0.4 \
	&& qmake-qt4 \
	&& make \
	&& make install \
	&& cd - \
	&& rm -rf swac-record-0.4 \
	&& apt-get purge -y --auto-remove \
		wget \
		libqt4-dev \
		portaudio19-dev \
		libflac++-dev \
		g++
