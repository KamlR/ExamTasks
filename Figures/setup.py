from setuptools import setup, find_packages

setup(
    name='figures_area',
    version='0.1',
    packages=find_packages(),
    install_requires=[],
    include_package_data=True,
    description='A package for geometric figures',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    url='https://github.com/yourusername/your-repo',
    author='Karina Mavletova',
    author_email='mavletovakarina@gmail.com',
    license='MIT',
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
    ],
    python_requires='>=3.6',
)