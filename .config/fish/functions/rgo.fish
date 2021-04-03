# Defined in - @ line 1
function rgo --wraps=rg\ --pre-glob\ \'\*.\{pdf,xl\[tas\]\[bxm\],xl\[wsrta\],do\[ct\],do\[ct\]\[xm\],p\[po\]t\[xm\],p\[op\]t,html,htm,xhtm,xhtml,epub,chm,od\[stp\]\}\'\ --pre\ rgpipe --description alias\ rgo\ rg\ --pre-glob\ \'\*.\{pdf,xl\[tas\]\[bxm\],xl\[wsrta\],do\[ct\],do\[ct\]\[xm\],p\[po\]t\[xm\],p\[op\]t,html,htm,xhtm,xhtml,epub,chm,od\[stp\]\}\'\ --pre\ rgpipe
  rg --pre-glob '*.{pdf,xl[tas][bxm],xl[wsrta],do[ct],do[ct][xm],p[po]t[xm],p[op]t,html,htm,xhtm,xhtml,epub,chm,od[stp]}' --pre rgpipe $argv;
end
