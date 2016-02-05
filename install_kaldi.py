# Installs kaldi to the named directory.
import os, glob, shutil

kaldi_dev_dirs = [
    'base',
    'cudamatrix',
    'decoder',
    'feat',
    'fstext',
    'gmm',
    'gst-plugin',
    'hmm',
    'itf',
    'ivector',
    'lat',
    'lm',
    'matrix',
    'nnet',
    'nnet2',
    'online',
    'online2',
    'probe',
    'sgmm',
    'sgmm2',
    'thread',
    'transform',
    'tree',
    'util',
]

def install_headers(kaldi_root, install_dir):
    include_dir = os.path.join(install_dir, 'include')

    if os.path.exists(include_dir):
        if not os.path.isdir(include_dir):
            raise Exception('expected ' + include_dir + ' to be a directory.')
    else:
        os.makedirs(include_dir)

    for kaldi_dev_dir in kaldi_dev_dirs:
        dest_dir = os.path.join(include_dir, kaldi_dev_dir)
        from_dir = os.path.join(kaldi_root, kaldi_dev_dir)
        if not os.path.exists(dest_dir): os.makedirs(dest_dir)
        files = glob.iglob(os.path.join(from_dir, "*.h"))
        for file in files:
            if os.path.isfile(file):
                print 'installing', file, 'to', dest_dir
                shutil.copy(file, dest_dir)

def install_libs(kaldi_root, install_dir):
    lib_dir = os.path.join(install_dir, 'lib')

    if os.path.exists(lib_dir):
        if not os.path.isdir(lib_dir):
            raise Exception('expected ' + lib_dir + ' to be a directory.')
    else:
        os.makedirs(lib_dir)

    for kaldi_dev_dir in kaldi_dev_dirs:
        from_dir = os.path.join(kaldi_root, kaldi_dev_dir)
        files = glob.iglob(os.path.join(from_dir, "*.a"))
        for file in files:
            if os.path.isfile(file):
                print 'installing', file, 'to', lib_dir
                shutil.copy(file, lib_dir)

def install_bin(kaldi_root, install_dir):
    bin_dir = os.path.join(install_dir, 'bin')
    from_dir = os.path.join(kaldi_root, 'bin')
    onlyfiles = [ f for f in os.listdir(from_dir) if os.path.isfile(os.path.join(from_dir,f)) ]
    for file in onlyfiles:
        print 'installing', file, 'to', bin_dir
        shutil.copy(os.path.join(from_dir,file), bin_dir)

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        raise Exception('Usage: python ' + sys.argv[0] + ' <kaldi_root> <install_dir>')

    kaldi_root = sys.argv[1]
    install_dir = sys.argv[2]
    if not os.path.exists(install_dir): os.makedirs(install_dir)
    if not os.path.isdir(kaldi_root):
        raise Exception('expected kaldi root ' + kaldi_root + ' to be a directory.')

    install_headers(kaldi_root, install_dir)
    install_libs(kaldi_root, install_dir)
    install_bin(kaldi_root, install_dir)