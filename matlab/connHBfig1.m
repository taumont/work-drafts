
cd /media/yuval/win_disk/Data/connectomeDB/MEG/599671/unprocessed/MEG/3-Restin/4D
load comp
pos=[ 974   595   178   165;974   439   178   165;974   284   178   166];
for compi=3:-1:1
    topo=comp.topo(:,compi);
    topo(3:248)=topo(2:247);
    topo(2)=nan;
    % cfg=[];
    % cfg.zlim=[0 10];
    % cfg.comment='no';
    % cfg.interpolation='linear';
    % % cfg.interplimits = 'electrodes';
    % % cfg.maskparameter='mask';
    % figure;topoplot248(topo,cfg);
    outline{1,1}=[0.500000000000000,0;0.499013364214136,0.0313952597646567;0.496057350657239,0.0626666167821521;0.491143625364344,0.0936906572928623;0.484291580564316,0.124344943582427;0.475528258147577,0.154508497187474;0.464888242944126,0.184062276342339;0.452413526233010,0.212889645782536;0.438153340021932,0.240876837050858;0.422163962751008,0.267913397489498;0.404508497187474,0.293892626146237;0.385256621387895,0.318711994874345;0.364484313710706,0.342273552964344;0.342273552964344,0.364484313710706;0.318711994874345,0.385256621387895;0.293892626146237,0.404508497187474;0.267913397489498,0.422163962751008;0.240876837050858,0.438153340021932;0.212889645782536,0.452413526233010;0.184062276342339,0.464888242944126;0.154508497187474,0.475528258147577;0.124344943582427,0.484291580564316;0.0936906572928623,0.491143625364344;0.0626666167821521,0.496057350657239;0.0313952597646567,0.499013364214136;-8.04061324838318e-17,0.500000000000000;-0.0313952597646567,0.499013364214136;-0.0626666167821522,0.496057350657239;-0.0936906572928624,0.491143625364344;-0.124344943582427,0.484291580564316;-0.154508497187474,0.475528258147577;-0.184062276342339,0.464888242944126;-0.212889645782536,0.452413526233010;-0.240876837050858,0.438153340021932;-0.267913397489498,0.422163962751008;-0.293892626146237,0.404508497187474;-0.318711994874345,0.385256621387895;-0.342273552964344,0.364484313710706;-0.364484313710706,0.342273552964344;-0.385256621387895,0.318711994874345;-0.404508497187474,0.293892626146237;-0.422163962751008,0.267913397489498;-0.438153340021932,0.240876837050858;-0.452413526233010,0.212889645782536;-0.464888242944126,0.184062276342339;-0.475528258147577,0.154508497187474;-0.484291580564316,0.124344943582427;-0.491143625364344,0.0936906572928623;-0.496057350657239,0.0626666167821521;-0.499013364214136,0.0313952597646566;-0.500000000000000,6.12323399573677e-17;-0.499013364214136,-0.0313952597646565;-0.496057350657239,-0.0626666167821519;-0.491143625364344,-0.0936906572928622;-0.484291580564316,-0.124344943582427;-0.475528258147577,-0.154508497187473;-0.464888242944126,-0.184062276342339;-0.452413526233010,-0.212889645782536;-0.438153340021932,-0.240876837050858;-0.422163962751008,-0.267913397489498;-0.404508497187474,-0.293892626146237;-0.385256621387895,-0.318711994874345;-0.364484313710706,-0.342273552964344;-0.342273552964345,-0.364484313710706;-0.318711994874345,-0.385256621387895;-0.293892626146237,-0.404508497187474;-0.267913397489499,-0.422163962751007;-0.240876837050858,-0.438153340021932;-0.212889645782536,-0.452413526233010;-0.184062276342339,-0.464888242944126;-0.154508497187474,-0.475528258147577;-0.124344943582428,-0.484291580564316;-0.0936906572928627,-0.491143625364344;-0.0626666167821523,-0.496057350657239;-0.0313952597646566,-0.499013364214136;-9.18485099360515e-17,-0.500000000000000;0.0313952597646564,-0.499013364214136;0.0626666167821521,-0.496057350657239;0.0936906572928621,-0.491143625364344;0.124344943582427,-0.484291580564316;0.154508497187474,-0.475528258147577;0.184062276342339,-0.464888242944126;0.212889645782536,-0.452413526233010;0.240876837050857,-0.438153340021932;0.267913397489498,-0.422163962751008;0.293892626146236,-0.404508497187474;0.318711994874345,-0.385256621387895;0.342273552964344,-0.364484313710706;0.364484313710706,-0.342273552964345;0.385256621387895,-0.318711994874345;0.404508497187474,-0.293892626146237;0.422163962751007,-0.267913397489499;0.438153340021932,-0.240876837050858;0.452413526233010,-0.212889645782537;0.464888242944126,-0.184062276342339;0.475528258147577,-0.154508497187474;0.484291580564316,-0.124344943582428;0.491143625364344,-0.0936906572928623;0.496057350657239,-0.0626666167821523;0.499013364214136,-0.0313952597646566;0.500000000000000,-1.22464679914735e-16;];
    outline{1,2}=[0.0900000000000000,0.496000000000000;0,0.575000000000000;-0.0900000000000000,0.496000000000000;];
    outline{1,3}=[0.497000000000000,0.0555000000000000;0.510000000000000,0.0775000000000000;0.518000000000000,0.0783000000000000;0.529900000000000,0.0746000000000000;0.541900000000000,0.0555000000000000;0.540000000000000,-0.00550000000000000;0.547000000000000,-0.0932000000000000;0.532000000000000,-0.131300000000000;0.510000000000000,-0.138400000000000;0.489000000000000,-0.119900000000000;];
    outline{1,4}=[-0.497000000000000,0.0555000000000000;-0.510000000000000,0.0775000000000000;-0.518000000000000,0.0783000000000000;-0.529900000000000,0.0746000000000000;-0.541900000000000,0.0555000000000000;-0.540000000000000,-0.00550000000000000;-0.547000000000000,-0.0932000000000000;-0.532000000000000,-0.131300000000000;-0.510000000000000,-0.138400000000000;-0.489000000000000,-0.119900000000000;];
    mask=outline(1);
    argin={'interpmethod','linear','interplim','mask','gridscale',67,'outline',outline,'shading','flat','isolines',6,'mask',mask,'style','surfiso','datmask',[]};
    chanX=[-0.0903767372844559;0.00376533397771597;-0.0489548919589357;0.237238581401759;0.0621339006920820;-0.410460708392958;-0.161925105624630;-0.0884941835659781;-0.184519148357768;-0.0941429774252133;-0.208995744809385;-0.0546025531143692;-0.171339006920820;-0.0451886518181784;-0.0470712055366562;-0.222175886246333;0.227823547401766;0.273012765571846;0.0470712055366562;0.337028653630504;0.0903767372844559;0.295606808304984;0.00188249708328777;0.282426666868036;0.256066383994140;0.233472341261001;0.312552057178888;0.190166809513202;-0.0470712055366562;-0.116737020158352;-3.39811140526170e-07;0.00188249708328777;0.0508363129736118;0.0451875191143767;0.0376561715366638;0.0395398579589432;-0.450000000000000;-0.227824680105568;-0.0922592910029337;-0.180754040920813;-0.129917161595300;-0.0433060980997006;-0.0884941835659781;-0.254184962979464;-0.141213616609969;0.00188249708328777;-0.284310353290316;-0.101674325002926;-0.286192907008794;-0.0470712055366562;-0.257950070416420;-0.190167942217003;0.225940993683288;0.406694468252200;0.291840568164227;0.308785817038131;-3.39811140526170e-07;0.310669503460410;0.246652482697949;0.133681136328454;0.212760852246340;0.0922592910029337;0.252301276557185;0.446233759859243;-0.0903767372844559;0.00188249708328777;0.00188249708328777;0.00376533397771597;0.173221560639298;0.0508363129736118;0.0451875191143767;0.146861277765402;-0.433054751126096;-0.135564822750733;-0.359623829067445;-0.222175886246333;-0.372803970504393;-0.353975035208210;-0.312553189882690;-0.291841700868029;-0.0489548919589357;-0.404811914533723;-0.105439432439882;-0.335147232615828;-0.0960255311436911;-0.184519148357768;-0.143096170328446;-0.225942126387090;0.139329930187689;0.144978724046924;0.143096170328446;0.214644538668620;0.120502127595308;0.212760852246340;0.0583676605513246;0.207113191090907;0.178870354498533;0.382217871800584;0.263597731571853;0.233472341261001;-0.0508374456774135;-3.39811140526170e-07;-0.118619573876830;0.161923972920828;0.00376533397771597;0.148744964187681;0.193933049653959;0.101673192299124;-0.267363971712610;-0.205230637372429;-0.144979856750726;-0.256067516697942;-0.141213616609969;-0.242887375260994;-0.203348083653951;-0.301255602164220;-0.0564862395366487;-3.39811140526170e-07;-0.0508374456774135;-0.0866116298475003;-0.384100425519062;0.182635461935489;-0.355857588926688;0.143096170328446;0.0979080848621688;0.173221560639298;0.269246525431088;0.129916028891498;0.0527188666920895;0.0564851068328469;0.161923972920828;0.257948937712618;0.143096170328446;-0.0414224116774211;0.274895319290323;-0.0979080848621688;-0.0941429774252133;0.120502127595308;-3.39811140526170e-07;0.0997906385806466;-0.320084537460403;-0.265481417994133;-0.192050495935481;-0.280544113149558;-0.239122267824038;-0.212761984950142;0.00188249708328777;0.00188249708328777;-3.39811140526170e-07;-0.0414224116774211;-0.241004821542516;0.0470712055366562;-0.212761984950142;0.0489537592551339;0.323849644897358;0.171339006920820;0.359622696363643;0.0960243984398893;0.0546025531143691;0.361506382785923;0.282426666868036;0.0884930508621764;0.182635461935489;0.327614752334314;0.146861277765402;0.184518015653967;0.335146099912027;-0.176987800780055;0.323849644897358;-0.195816736076239;-0.0508374456774135;0.0508363129736118;-0.0338910640997082;0.122384681313785;-0.444352338844567;-0.186401702076246;-0.329498438756593;-0.231589787542524;-0.250418722838707;-0.176987800780055;-0.167573899483865;-0.131799715313778;-0.114854466439874;-0.242887375260994;-0.310669503460410;0.00376533397771597;-0.321967091178880;0.0941418447214116;0.261715177853375;0.188284255794724;0.241003688838714;0.101673192299124;0.00188249708328777;0.378451631659826;0.109204539876837;0.122384681313785;0.241003688838714;0.370920284082114;0.257948937712618;0.139329930187689;0.359622696363643;-0.0941429774252133;0.419874609689148;-0.0583687932551264;-0.143096170328446;0.0884930508621764;-0.150627517906159;0.0941418447214116;-0.271130211853368;-0.263598864275655;-0.384100425519062;-0.378452764363628;-0.256067516697942;-0.122385814017587;-0.148744964187682;-0.139331062891491;-0.0527199993958913;-0.0451886518181784;-0.0941429774252133;0.188284255794724;-0.269247658134890;0.0960243984398893;0.0470712055366562;0.0433049653958988;0.389749219378297;0.212760852246340;0.152510071624637;0.305020709601175;0.0658990081290376;0.169455320498541;0.273012765571846;0.389749219378297;0.207113191090907;0.225940993683288;0.450000000000000;-0.0696652482697950;0.433053618422295;-0.160042551906152;0.0546025531143691;0.0771965958475079;-0.0470712055366562;0.0884930508621764;-0.367155176645158;-0.207113191090907;-0.333263546193549;-0.139331062891491;-0.163807659343107;-0.306904396023455;];
    chanY=[0.170134764386448;0.0714764755592881;-0.214429426677864;-0.371476080046512;-0.256711719966408;-0.0593963288504157;-0.0775171421828877;-0.0271806267295444;0.309060604422624;0.274832533298880;0.335234453381568;0.260738831048808;0.244630386719208;0.0755035866416879;0.123825360015504;0.194295057804192;0.141946173347976;0.292953346631352;0.123825360015504;0.349329342169968;0.224497204383864;-0.121811804474304;0.313087715505024;-0.0775171421828877;-0.240604462175136;0.0271813267871574;-0.230536684469136;0.0795306977240878;-0.450000000000000;-0.337248008922768;-0.399664671084984;-0.0734900311004879;-0.441945777835200;-0.0191275911030719;-0.292953346631352;-0.357382377796440;0.00100677777060002;0.0271813267871574;0.0271813267871574;-0.0271806267295444;-0.115771137850704;-0.0191275911030719;-0.0956379555153597;-0.139932617806776;0.292953346631352;0.123825360015504;0.359395933337640;0.329194973296296;0.228523128927936;0.0251679017651735;0.208389946592592;0.133893137721504;0.196308613345392;0.270805422216480;0.228523128927936;0.307047048881424;0.216442982219064;-0.305033493340224;0.345302231087568;-0.117784693391904;-0.198322168886592;0.0231544648778064;-0.301006382257824;0.0956379555153598;-0.383557413293712;-0.0231547021854717;-0.327181417755096;-0.220470093301464;-0.349328155631640;-0.166107653304048;-0.115771137850704;-0.286912680007752;0.190269133260120;-0.0110733689382722;-0.0493285511444161;-0.0271806267295444;-0.218456537760264;-0.150000395512776;-0.296979271175424;-0.123825360015504;0.309060604422624;0.264764755592880;0.381543857752512;0.355368822255240;0.0734900311004880;0.186242022177720;0.133893137721504;0.145973284430376;0.184228466636520;0.290939791090152;0.133893137721504;0.256711719966408;0.417785484417456;-0.154026320056848;0.401678226626184;-0.244630386719208;-0.0291941822707443;0.0895972888917602;-0.0372484044355439;0.0855701778093603;-0.0694629200180880;-0.262751200051680;-0.232550240010336;-0.246643942260408;-0.174160688930520;-0.415771928876256;-0.294965715634225;-0.196308613345392;0.0251679017651735;-0.0815430667269604;0.0835566222681603;-0.240604462175136;-0.166107653304048;-0.101677435600632;-0.242616831178008;-0.172147133389320;0.441946964373528;0.262751200051680;0.353355266714041;0.226510759925064;0.345302231087568;0.182214911095320;0.272818977757680;0.0875837333505602;0.0755035866416879;0.246432738438173;0.156039875598048;0.234563795551536;0.309060604422624;0.359395933337640;-0.0734900311004879;-0.141946173347976;0.0372484044355440;-0.349328155631640;0.0916108444329600;-0.196308613345392;-0.276844902301752;-0.236577351092736;-0.127852471097904;-0.276844902301752;0.150000395512776;0.156039875598048;0.0815442532652877;-0.0775171421828877;-0.369462524505312;-0.198322168886592;0.450000000000000;0.168121208845248;0.357382377796440;0.216442982219064;0.278859644381280;0.0251679017651735;0.254698164425208;0.0734900311004880;0.250671053342808;0.381543857752512;0.274832533298880;0.276846088840080;0.260738831048808;-0.156039875598048;0.363423044420040;-0.0291941822707443;-0.125838915556704;0.0775171421828878;-0.168121208845248;0.0231544648778064;0.00704744439419974;-0.349328155631640;0.145973284430376;-0.298992826716624;-0.168121208845248;-0.0694629200180880;-0.290939791090152;-0.331207342299169;0.0956379555153598;0.0251679017651735;0.0775171421828878;0.0835566222681603;-0.303019937799024;-0.127852471097904;0.383557413293712;0.234563795551536;0.417785484417456;0.345302231087568;0.296980457713752;0.0231544648778064;0.236577351092736;0.125838915556704;0.210402315595464;0.305033493340224;0.276846088840080;0.329194973296296;0.407717706711456;-0.218456537760264;0.379530302211312;-0.0614086978532885;-0.0996638800594323;0.168121208845248;-0.188254391180592;-0.0110733689382722;-0.0533556622268160;-0.145973284430376;-0.0654358089356883;-0.254698164425208;-0.286912680007752;-0.0976503245182324;-0.405704151170256;-0.147986839971576;0.0895972888917602;-0.0372484044355439;0.00302033331179986;0.0855701778093603;-0.190267946721792;-0.0614122574682699;0.347315786628768;0.182214911095320;0.399664671084984;0.168121208845248;0.125838915556704;0.133893137721504;0.288926235548952;0.170134764386448;0.168121208845248;0.216442982219064;0.345302231087568;0.335234453381568;0.347315786628768;-0.174160688930520;0.441946964373528;-0.200335724427792;0.0251679017651735;0.00503388885299990;-0.0815430667269604;-0.0271806267295444;0.00302033331179986;-0.317113640049096;0.194295057804192;-0.242616831178008;-0.214429426677864;-0.315100084507896;-0.117784693391904;-0.389596893378984;0.164094097762848;-0.156039875598048;0.00906099993539968;0.0372484044355440;-0.200335724427792;-0.232550240010336;];
    chanY(2)=[];
    chanX(2)=[];
    topo(2)=[];
    scale=0.95;
    chanX=chanX*scale;
    chanY=chanY*scale;
    fig1=figure('position',pos(compi,:));
    axes('Xtick',[],'Ytick',[])
    h1=ft_plot_topo(chanX,chanY,topo,argin{:});
    %axis tight
    xlim([-0.6 0.6])
    ylim([-0.6 0.6])
    colormap gray
    C=colormap;
    colormap(flipud(C))
    %saveas(fig1,['/home/yuval/Dropbox/MEGpaper/fig1_',num2str(compi),'.png'])
    %ylabel('Normalized amplitude','fontsize',20)
    
    
end
%set(
fig2=figure('position',[1152         284         500         471]);
axes('Xtick',[0 5 10],'Ytick',[])
hold on

for compi=1:3
    plot(comp.time{1}(1:20345),comp.trial{1}(compi,1:20345)+(4-compi)*2e-13,'k','linewidth',2)
end

set(gca,'fontweight','bold','fontsize',20)
xlabel('Time (s)')