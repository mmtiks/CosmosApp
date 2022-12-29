PGDMP                         z            postgres    15.1    15.1 &    1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            2           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            3           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            4           1262    5    postgres    DATABASE     |   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Europe.1252';
    DROP DATABASE postgres;
                postgres    false            5           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3380                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            6           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    24576    Company    TABLE     �   CREATE TABLE public."Company" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "priceListId" character varying(255) NOT NULL
);
    DROP TABLE public."Company";
       public         heap    postgres    false            �            1259    24583    Destination    TABLE     �   CREATE TABLE public."Destination" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "PriceListId" character varying(255) NOT NULL
);
 !   DROP TABLE public."Destination";
       public         heap    postgres    false            �            1259    24590    Place    TABLE     �   CREATE TABLE public."Place" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "priceListId" character varying(255) NOT NULL
);
    DROP TABLE public."Place";
       public         heap    postgres    false            �            1259    24597 	   Pricelist    TABLE     �   CREATE TABLE public."Pricelist" (
    id character varying(255) NOT NULL,
    "validUntil" timestamp with time zone NOT NULL,
    "dateAdded" timestamp with time zone NOT NULL
);
    DROP TABLE public."Pricelist";
       public         heap    postgres    false            �            1259    24602    Provider    TABLE     /  CREATE TABLE public."Provider" (
    id character varying(255) NOT NULL,
    price numeric NOT NULL,
    "flightStart" timestamp with time zone NOT NULL,
    "flightEnd" timestamp with time zone NOT NULL,
    "routeId" character varying(255) NOT NULL,
    "companyId" character varying(255) NOT NULL
);
    DROP TABLE public."Provider";
       public         heap    postgres    false            �            1259    24609    Reservation    TABLE     1  CREATE TABLE public."Reservation" (
    id character varying(255) NOT NULL,
    "providerId" character varying(255) NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    "dateAdded" date DEFAULT CURRENT_DATE,
    passcode character varying(255)
);
 !   DROP TABLE public."Reservation";
       public         heap    postgres    false            �            1259    24617    Route    TABLE     {   CREATE TABLE public."Route" (
    id character varying(255) NOT NULL,
    "pricelistId" character varying(255) NOT NULL
);
    DROP TABLE public."Route";
       public         heap    postgres    false            �            1259    24624 	   RouteInfo    TABLE     �   CREATE TABLE public."RouteInfo" (
    id character varying(255) NOT NULL,
    distance bigint NOT NULL,
    "routeId" character varying(255) NOT NULL,
    "fromId" character varying(255) NOT NULL,
    "toId" character varying(255) NOT NULL
);
    DROP TABLE public."RouteInfo";
       public         heap    postgres    false            '          0    24576    Company 
   TABLE DATA           <   COPY public."Company" (id, name, "priceListId") FROM stdin;
    public          postgres    false    215   �,       (          0    24583    Destination 
   TABLE DATA           @   COPY public."Destination" (id, name, "PriceListId") FROM stdin;
    public          postgres    false    216   s.       )          0    24590    Place 
   TABLE DATA           :   COPY public."Place" (id, name, "priceListId") FROM stdin;
    public          postgres    false    217   �.       *          0    24597 	   Pricelist 
   TABLE DATA           D   COPY public."Pricelist" (id, "validUntil", "dateAdded") FROM stdin;
    public          postgres    false    218   �1       +          0    24602    Provider 
   TABLE DATA           c   COPY public."Provider" (id, price, "flightStart", "flightEnd", "routeId", "companyId") FROM stdin;
    public          postgres    false    219   �1       ,          0    24609    Reservation 
   TABLE DATA           i   COPY public."Reservation" (id, "providerId", "firstName", "lastName", "dateAdded", passcode) FROM stdin;
    public          postgres    false    220   �Z       -          0    24617    Route 
   TABLE DATA           4   COPY public."Route" (id, "pricelistId") FROM stdin;
    public          postgres    false    221   �Z       .          0    24624 	   RouteInfo 
   TABLE DATA           P   COPY public."RouteInfo" (id, distance, "routeId", "fromId", "toId") FROM stdin;
    public          postgres    false    222   :\       �           2606    24596    Place Place_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Place"
    ADD CONSTRAINT "Place_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Place" DROP CONSTRAINT "Place_pkey";
       public            postgres    false    217            �           2606    24601    Pricelist Pricelist_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Pricelist"
    ADD CONSTRAINT "Pricelist_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Pricelist" DROP CONSTRAINT "Pricelist_pkey";
       public            postgres    false    218            �           2606    24608    Provider Provider_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Provider"
    ADD CONSTRAINT "Provider_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Provider" DROP CONSTRAINT "Provider_pkey";
       public            postgres    false    219            �           2606    24616    Reservation ReservationId 
   CONSTRAINT     [   ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT "ReservationId" PRIMARY KEY (id);
 G   ALTER TABLE ONLY public."Reservation" DROP CONSTRAINT "ReservationId";
       public            postgres    false    220            �           2606    24582    Company company_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Company" DROP CONSTRAINT company_pkey;
       public            postgres    false    215            �           2606    24589    Destination destinationPK 
   CONSTRAINT     [   ALTER TABLE ONLY public."Destination"
    ADD CONSTRAINT "destinationPK" PRIMARY KEY (id);
 G   ALTER TABLE ONLY public."Destination" DROP CONSTRAINT "destinationPK";
       public            postgres    false    216            �           2606    24630    RouteInfo routeInfo_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."RouteInfo"
    ADD CONSTRAINT "routeInfo_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."RouteInfo" DROP CONSTRAINT "routeInfo_pkey";
       public            postgres    false    222            �           2606    24623    Route route_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Route"
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Route" DROP CONSTRAINT route_pkey;
       public            postgres    false    221            �           2606    24651    Reservation ProviderFK    FK CONSTRAINT     �   ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT "ProviderFK" FOREIGN KEY ("providerId") REFERENCES public."Provider"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public."Reservation" DROP CONSTRAINT "ProviderFK";
       public          postgres    false    220    219    3211            �           2606    24646    Provider RouteId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Provider"
    ADD CONSTRAINT "RouteId" FOREIGN KEY ("routeId") REFERENCES public."Route"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 >   ALTER TABLE ONLY public."Provider" DROP CONSTRAINT "RouteId";
       public          postgres    false    219    221    3215            �           2606    24636    Destination priceListFK    FK CONSTRAINT     �   ALTER TABLE ONLY public."Destination"
    ADD CONSTRAINT "priceListFK" FOREIGN KEY ("PriceListId") REFERENCES public."Pricelist"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 E   ALTER TABLE ONLY public."Destination" DROP CONSTRAINT "priceListFK";
       public          postgres    false    3209    218    216            �           2606    24641    Place priceListFK    FK CONSTRAINT     �   ALTER TABLE ONLY public."Place"
    ADD CONSTRAINT "priceListFK" FOREIGN KEY ("priceListId") REFERENCES public."Pricelist"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ?   ALTER TABLE ONLY public."Place" DROP CONSTRAINT "priceListFK";
       public          postgres    false    217    218    3209            �           2606    24631    Company priceListId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "priceListId" FOREIGN KEY ("priceListId") REFERENCES public."Pricelist"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 A   ALTER TABLE ONLY public."Company" DROP CONSTRAINT "priceListId";
       public          postgres    false    215    218    3209            �           2606    24656    Route priceListId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Route"
    ADD CONSTRAINT "priceListId" FOREIGN KEY ("pricelistId") REFERENCES public."Pricelist"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ?   ALTER TABLE ONLY public."Route" DROP CONSTRAINT "priceListId";
       public          postgres    false    218    3209    221            �           2606    24661    RouteInfo routeFK    FK CONSTRAINT     �   ALTER TABLE ONLY public."RouteInfo"
    ADD CONSTRAINT "routeFK" FOREIGN KEY ("routeId") REFERENCES public."Route"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ?   ALTER TABLE ONLY public."RouteInfo" DROP CONSTRAINT "routeFK";
       public          postgres    false    3215    221    222            '     x������1���S�Tl��lݷ��-��z�d9�$$풼}]����,<|�F��Ij%�b��ֲ�!#�%$jl�^�c��p��Qyd"�d	Б��,�x�K��(& �y�ء�"��x����=�?����ƴY�A�,�ʾp�:6������a8��q��V�s�F)�{%N5�����C�k0����DQf]ADa�K~r����;S�9���(�P��L�1�[}��-�Ô�BI�N8��0��ZC�+�����tXiV�h��B<(٦�ܠ`��)��vշ8�>��t�ǬQ.�P�whm�A��y�en�Oz��c7�p��m8�J���Zf�j��4��a�{���zy����w�C����n�/^�      (      x������ � �      )   �  x��V;�+6��wa JI M��&H�4�HH��g���C�Vc5r�C�J�&�R�M;`J�h��/_?�������9��7��	�b���V�z>�"��D@TEJ���ں��������=�n�z�{�t�@�,��hcY��C��2 uW��;CB]��X���i߿�yP���sAO�f�
5؂������.5ƉjX9@�Lc{���m?���lm��
1�
l,oF��n���{c�@c	��Q��o��~ɰ��KN!�(r:t�Rb�|n�p"�� �V��#�v��=[�ӌ��{��`X��;5��9�S��� �v�\L��5�C�p����ճ��f�7��Y3k� 5��Ժ��}�B��e�n���2����a����g%�\����x��gђ���d8�K��S/y�A�ث��p䞘��E�huU�qVT����-WK)���1�{��)�R��ȬPl���5&>~�ϯ��� ����X�^X�{���+��+@�6<�C9�R���U}��Ƒ��_��ϯ��]ĩ*���l���d����F��}�e	���Q�
���ͭ4)��yճ���cPV=��e���d��"w=�a�y�N?��J.��
ﲎG��깇Yy�t�S���fgP[�')-�;�24�W���Ə|�]@+�����;Yf(/#�)/+VP�.�'�m�/)V
p��|�꺶Y*�mEK4?���]�?����\�Lg      *   T   x�Mɱ� �:L�>2���̒����̵�6|�q�*��Ȍ21bUo`��P'١�5��K�_D/��fk���MON)��M=      +      x��}K#���u��d����2}��	���{ = �M��TR� ER}�F�r`e5��.�2=8˹�J�����Ѽ4i��ٿ��i�O�7{�6�ҧ4���|�*5���S��l$�R�V�j4电��"���_c�Eِ�ʺte|ξO9�?�Պ���6e�*�ǳ����dʋ��޼9�j�������et�*��/�?�I��&W]
���
�hdT�\U��Zmz��q�;W�+z([�V1[�B�=V�g��tt+m쩴������r��4����%���d{I*q���W�I�{�"^Z*\�%�
�p�*�FS%�O��R�A�����%�N�T��R�����ד�aS:��%�KM�K��JP�k�߲J)��aTo����7g�J6�2-�O���9��H��{k=���gy��d&��_������bUct|Ț���Q��8�䓱�����'�`d�Zi;Y����W��6b���a1U��qԹ�J:�K���}>�2���P9N��~�4K��(��]�N�]���ÑJJd���Ro؉��e��r�FhԬ���)Bis݅X�CiC�n|��W��8�
O�dũ�_l�TlǾ�Y��ۤ+H��&xR�n��4K�[��Rt5̀Q(��U����ؼ����w�����v���+����)�"�Q���S�*Ր�.� 9-;���4�N�6;ܙ�&��+�?���9���MÇ�F�I�r
]2���[��e������Rtڗ��/�s�tI�Q�6{�	>�,P)��jB�ٵ�c��a�5c5|S�O5�r��-�e]��;�\i�8LZ߼!��M�g�s.\X�����>�i(x�S��vP��\�}�0�!:鐞��������R�X_m fڰ*_Ykp�����枴�n�05'�B�p�4�/&�0�8�]��ݰOd�$|�F�᪞+�����9Np�͗�5������^��E��8L�7�����,}�*Q�%�P�so�*��M���Ϳ��l�o6W��m�/e07��]Hv���tlu_�RFQ3J��F�R���mBj�UtĢ�e��ᝊ�Z�֙��L��麐@;���d��ѳtI�:�����dd�5#p�ᏕG�	@�c�r�X檁� �
���X��	/, 4]|s�H'�ޗ�G�ь-g��K\I �T�����8�0܈�l�zC�w���v����%�م���,]�zɳ8xG@9#l{ �Q���IÔX=��5H��B��������ÿ�%���#�+9Q�5��v+a�j�o�F̢<��<���k킻[����,]�zɷ��M�DWr0����R2���¡G��N�"�1ܸ���y�.i�M���:�d�X������71�?�exC�]�����_�x���o�ۗg��*}���p���8���Ŀ��oLdH5�Xj¶,� �
m���1.�4`���Uk�����6��z�>�u�@�"Йp��pe��� �Ƅ�&J��x����p�kx���|�Ϲ�}�n8�H\yED�� v�e�q�2���yǉa@�#��nZ�~`�v�>!C���5/�,���,��
��7��N��%x���D��=K�|�
����u  �*Q"L%�لb�i��vP�P�m�.�� �f�޲b����.��Փ��`,VK �s�;g�t���c���a��i1�<���z��=�+
؋XfU7�ix~l��>��v�_�����Q�ĳ�9�D��x�@+6<���Nؒ �#��ƈ���I桓�T��E̾�
��&m47؟챆�#��n��u5��4�1�RP:KVl��hj���U+�9��bncs�q���<���.]�yɤ9�;<�^����18�s*�ы�����Ѱ�;�E�o~�ǘ�tE�%�a�Ѝ�.C"[0�d:��"|̈i��#����d�tr�&��mno���6!�Y׊ӊ2��,$��ڐ�A��_�G��)U#[�2�]���>�K�tɜ�R�M-���H�>|�;}.�����Â❨��E�;.�;hH8����"�k����#��' ]�c�Ќ�#XדL�w<W��Yi����M���R�R�H�@��C@�4ig�7p��eɒ�N,�@ƞ;��[߄K��|��D�V�}���p���?Tg�MK*U�j��Z"�&�h���Ӕ
��O�'���q�IWt^r&ؠ�k�qr\�nI7l�ʦuĆ�^Q/���d��ͧ�U�t�!}l�k����
s�TOР�6�ƣ��)�]���g��I'�J����f��:{s��*�Vඋ�Q�S�����O����\�h�>f�����@pK<����6\S>f�
���O�q�������9�c(7�'��`S��
�DP)|�K��6��k�76G�3���1W

�W�/�+���;Y����>Fզ�L�G���Fko�/��96�3�G�D(Q�`6�sj��_�)�/�]��Lt@`~�p�Q�.�dr������\p�E�`�x�v͝�	Յ@*/��Mx#5���EJ��L�Β������i�_��k��Zk��(^��v7Z5�aC�!����d�|��y�K�i�.�dϒDO�ܪ���<��9�_�l^ƃ!��%{���:[���$��%��R�:k�u��9�mP7q����G�t�D[~[��3��ܼ���s��tm�W��������x�V��#cF����N�E��3��b��#����ۥK:/ylE�)��#�RXrA�h(Q4ؖD�M�~q����٘����;ߥ��FSi��0؃R���P��,����*g��|�v�-G�;2�8��'��g�s{���0B�g"�U���kQB��:�7���'4�X��{�>w(���R���1����X`@�e�+��WDS�X۷�A�'��7x޲�{L�K�T^�i� ݐ� 7Y����ҽp��s�1�;�)p=��t�s�ڻtI�5����@g٦�u�Q7�'|����X��5? ːc�]+����Þ/�+}ΚGU���p�^�۔jV�p� ��@�e�3�&c>�s�s��9�=��#}ΘGgϙ|��!�*F7)l���P�up��}k"sl�������փ���#HT��[>��A`Q��t=���:�Z;�ghD��C~�u�h�h��x��� n@�Q\�ۇtWe�hʦ���f�ʩ�6����o��*n���#�{VCRz�.����X�+ ��i|Sz0̝��#��O�!�P{N�Vy⤤��tI��QkB�ؠ��Ő���F�`LC������1�R��n;��o}.)�m��1(IFQ|��S�!	w��E�^V�kz�%�)fd��0z�H���9�}�	Ϋ��V|Jrި�a��j)HJ���HVluO�G�{�ɥ>s�.���bْD�wR��ҥ���S�lO���×��Tt�ՙ4ӖX2i�>��a�d4̽;��;���\�����
���d��(�q�ٲ9��@��%���݈	4Ѐ!JW�c���@��e	�}x{{�qv�c�����8wH�S:c�Iĭ��o���Ik�L�R���;;a�=�"��\�@�!}�:�?�GR1��Zw��$�_@rtj�חה�;LI:lA{8����6l>�)��%�ײ�zh��Au){�*���A#��EW�F�A|��i������]�4�qH�t^bG�(ߑT��ը]!�
�ぬk�d:f���O/�`�\O�ۥk ���C��`�Q :���:�)k��ƶ��aDܐ�0����c=K������nY���Q
M�7Á�����M3@�#r�4gi;�q7�s�������Y�X~��V�!�k,/����?)�{��Vѳ�ѿǛ�Z�G`_�h����P�����K9╮��t�H����G(ҧ�o*ɴhbmr��7��?�1���F9�;�%���C�hg��i �k�O@��56|����Bd"��d�z/�����I�g��K��	�SƇ�&����;^�    ��.7JM �z�NfZ踗���Vq�f?a;�*=��&�b���/��G,����2:��?�����s&d���K���bR�z������V=��	[�Ԝ~	f�.�����:��4�`��M~_j�S)�a���r���,�^R ��ķ����Nނ�/��9m|���%���AO�{I� ���^�*�
bD8���8 Z�t��.Y\���SJ����!}�6L��FK3������;�s�V�dC�2�8{6��n�mB3K�[��� &�Ib�(�cO�D��I�2�q�
%��c��7O����pI��̝˰�i�f1I�ۊp��#��,	qW��_���4&���٤rH��*Y�aGz�6d�ʗ�c�R����y;w�/Kyk�L�wH�3,���a�AJ��dA�a}ȅ ��4X��+����^��<K�z�(a��]Q�m}W��Dx4F�zd�7�_���p��3X �\�͟�p?K��^J$�6�ª��lP���1�s�l�6����騐9�����+}�轤�>�;���`��^>�#\a	�aT�����z��=LXʹH4���C��ut��H��Ia���r��U����^�ܷ=|�vC�zx>��� b@��z� ���yR�M�+���&��Ԁ@[��8��?}�'�ۥ��%j}��0_6>��2u�J��gc{��.�:����[9�J�DU���[p���w�}i�a�G�f���D+�d�_�sJS�h|��Z��h�%�"��k�4��!�ԃ�9��<j��.�_iÞ�:Y匔���$7�ۡ���(���
�ԆǃwN�y��$�ಜgb�I��D9h����g.��T*���+;P'��c��ޤ�����P�W�Q�rD��4HR�4��M��j�&}P����eނ�(Ҟ�jA�݇K��3�p?6��^��)�>[�w�s:�K�p֭I���Y*q��u���(��RO���2���fNm>�8�J�3f�%{��ȨI�7������\�5F;^�`<���o1�n������=?�%��<7Bٮ�H�Ѝ �a�
x�3B_ӡ{�v|ۀGf܇���pփ}�ϭ3"�P�z��VU��U������Phmo�?ҙ��h�x��ks�u|�K:/�����)��ʃ9k�P���B�_:9��{˻��_���L<96�W���ZUϨfT�TOO��V�f��g'DV����Ô��b���=�̆��*��tIߥLA��]�-�p&q & �˩F�g�]Ʈ ��o��S¹�B��;6�7�J���`�NI� �YZgD�C�[c���%�\�k=l��i~(L~�>g����%=�8��ip��ь��5Ҟ���rHG�R�3�BC�Y��.�TkRd�S����xHc�a%�R��T��g�f�\�a���׳��tM��uk��FKV،p
�1�I N��@M��i�[��JH�,}n���yN�{(jiD��M])�L��[��0�N����'��Gk�.}�i`��%`�q�Bj��Z�B n�M�����w_�yc�ǱU��D����a��R�S��$:S ]m�`Nތ`�Oe>�ԙs>���%��"��m�A�$͋��Q�ҋ��=�,����]�}����f1G��.}6��=XT=�i7���!n�F3b`���m���X�����,�.IwF@/_!�|19������h�pC�r�	p"^�
2\v)�(o���:ib�Ӹ!:�%�i�g�����J�� ��X��QZ�<��Q��p�H�^	��J�?�|����͙/��^�L��+E�mUK����+��o���:�d��Y���?���%ޥK�).'p��7a �.F�Z�|��rm�� �zuͱ����U��U_��K\@2�LQ��Va0����,N%�v�F���!����4E�,}�6��f�����N:J�Q��"k	P���s�&2�U=)�v�8H?	�[�Z���S�ME�F�o.pDї�'�M\�]|doej[*�n���9Ay�PZ�����1k	��X&@3�iF���q�s��S��B��%���v餓~;ʰ�!��T<Cs,�L��&�8uJ|J[�c<������K�q�h��<��2�UP�I�EUP���h�����r�s��v�Y��M7�z߰Qm��됡{x1E�X@��Ś��ו����� �qpd�w�Jk�RǇ�(M�J�O͈��i��`ɲ���ϓyh}1 ��2z0�C����#'��I�ţH��z��B��⠙��<�h��4w����!}��9�|�
�7q� �x��al0y� �w��6X}A���<.]�7�R;L��d2V�p���u�I��_�j"�.�㷬�g��������I��+Q"(����y�$�6bw�}��ց�2ʳGcZ%��L��q������-�:�X�s��G��L��9�Mu�`?P�K���'��m�!�se�#�i�N�fېT�?�Q��`k��Z
{��$���Q`�6E�*���d�S��Ygd���Y�����n�WKu�d�bT�/����P�����
�>m��9�I���;ϔ���\���!vmIf�t�
�P���/���/�h�z��x�O���c~�KJ�U�C�ꥯ�s�cp�~�G��J�h�!�y	�I;�<p�s�|�~�KJ��)Cӱ�z.7		�j)k���,؇βL
��r<�6��>-��&]�z��Q�[u-�g>d-�RflF`H
�42NZ>�:F��Պ!��o��<KG4��y ��iN�e�s�a�1�@Ҵ���?�xv��snF�#��l_�s;�����P�s¥M�)�^�sk�k��KE�o3����o.)��vׯ����R.6Jsw���A"t^ajΝ��W��L��>��4G��<�Kw�!][楩u�5)�����HCBI�UD��eęLe	��\S��؆����l��>��GΖ^P R(a:��G�hdf�m�]�1�m^�Y���ZƯh0"ջT��ia���eDc�D�����M�AПA&;������! C{�M�)�E
��L���X.v���K�������U&�1�6��y���[�wt�u�2ޤKZ/9D]���U�c;�<y'�e�AVk}���8u�~�(���oK������sKm`PX�X#��N�5�`�z���������ۃK�iRI-�Y���Z���>V���7^
"�Z�s�����^l��2"i����X�b�xO�C�i�>g�Vp�.��BP��3�/^z�t�8-c-�����z���l
{���.]Rz�;�i遱
����Y��ʸXv�%9+����'����}��� e���S�]��Q�.�u�i��G��!����Kr���Ӽ}=C	z���� ?K��^K�������x�ұ�Z9���zD9dy[=����(6��|��-u�ڃ��)�j/�W)�n�X�O,���5�i2�vp�bZ���N��>�s�0x��#� �<�����]S2+}�/�3N���,]Rz��៭�%�5�d؊5Vի�4BM�Ɨ�R�xu�ڜ�Z�S�ӿ|�k��RW�ruaHl�Ei#QK�lf���<�_�L�w�>m�����c*�W���R�ع9��/�V�PH�lC��p.:&P۷���w'>�S�F�K��hPe.�	�df'�!�CR�.�A�慇5ɼå�x��? /��,KG��KḤ�P�B����+ ��}sTj�_�v�$�gU�2f�TXPg�:~b��#���"����Y�~�B���3�����k�<)_4l�c�@;d�h�dl ,�o�Qg�卟��jP�6�|kX�n�C���Z�]���y%e*=�.��P�hqH���m>q���� %���2mq����%�ך���D�Z�y�Ms��ujTCn"��K�!O�ᲄ����0Z3���%���l��d���Kݽm�5t��K����Ç���շ*�o7�7��K�x��<`�*E+�$��V]s	�#�^ �  ҏ�0S똌�:��Y����ܥkJ/-K�uA0����Vਗ��ˠI/O]/�db���O��_��#}9���v���k#�5$یY��1?�|�x��y"�C�s��,x�1��eJ*��8c�v�R8��Fn��"��=sXJ{��D2�~�>�Э��xxU������v��i��"A-�.��tݟ�َ�����^g�K�ۆ����O�4��Ft��P}�ֵ5�mؚ��}߯'�����	��ɯ_JzH�<˶C.oCx��W��z?�&6|��0�8oNK���*�&]l�����t��iM�{� �ɤ9�Mmʠ��ɗ�2d5���U�сܝ*Ɂ����5bYt���<Mp0�8;زUԒ<q��S��vD�'5<��Ε��},���-�ojR�]��௩�HL���N�9X�7��
|촔�>�_bǛtI뵻�c]�W�I���fҍ�3\n�o�!s��}����p�K+vmf��k��0����{e�2��H
TSB4 �z���� �:އ7�q�D�My��0���,�A+�(ڪSF��X��Í��(-YQ.�f='3�y7m�����#}N뮹�b��Z:��M"��Z��[��҉����L�E�Ћ�����.i�n!Ȇ3�ˁ������P�i࡫~pF�o�[�>�m�r>�O�e�G��<$��(�����f�C�G��K�����4�H/ŭ��˭�5u��Kub�����a����_�tI鵛U��Yz���B^�$�xO�ң$���i��f����/�sہ>��5�Wc�c��H]��Nz}�d8��־�3�)�a���p|�7x�'��J�� \@�b�S�J�A����1�G���`>h��=&g��|�m��%���:a+٣�ǭqH�a	?-A��UĴ�b2�&7]>�e�S���a �x���9��i�2�� ��ٍ���j�l2���V9!ɺ}�o�{<����죀Du)H�����C���)�RK�MV��c��)�.I�=B�_��!)��tI��{V9��*S$��� �hn��m�ż,�<�m.>]x�-�D�x�#���>�i�Od�?)b* jVf�He� ���}|.M8bAw����~��K�[i�<X��p�lU��&|S΅�c�l�I2�n���S�gZ@8s��0�5�D��e}�'�e{;�N`R��'-SWx�b�Ñ�T��y�C����hj0�,V���ʥ��i��\A�07fQd��G{VG�߻��J��%��ʮ����,�X6��U���%K���p.rK��&�o=�����������9�i�~!�SC]���U��&K-ϐ�{���}��DA����W�]�q��R��6�Knc.*�&w������I�O
��$	ma�rP��J�l�iήي_����~s��z���A�%[�Ě(��v@�KR�'�O"n�z*��:�~6����P��K:/�R�#��G�/9f��vQ*Ճ�i�	3��
�o�RD�9��6��8��J��٘�M��r���+�_��&e�zv�������r|��~����388�kJ/��(���؟R���WjH��n[�H%F�<O�[���u1���%���.i�i!������X�R���4"L<�g׺�LJ͞!�b�p�J�ܥ_��k�'��᥵�rE����W�Z�{�d�9��B�Z~Y)Ԛ��>-�t�>1�4�95�<Y�����\�HHFaؗL47q�����9�~Z=��:�y,�^���A�R��A�-����m�A|O�Tϖ����Ϲ�tI�%g���T3�\d��rv��V Q�ۭ�R2q�/9x����T�ֱc-���-�I�&I�b�M�JSǀ��՗����#G�e*���������%�׎�8��lR��(�mY�T@��,׏4�/w2�����Ku����/%��[f�s۰�X���Z��L��J��2����^�H_[�:�;��4�x�K�3�&W��AR�+���L�E�E^�$\�Z˝{f��d�_�vv�k��Y�N��M�B�$t�h���r�"�I�7�\�&!d���~���VD{���>����!yf���yan �c�(��ŏ39s�<{�z�q=�f�s�1z�l<+�U�.�I:٫.�=�j�J �����^�gv 	��rG���`�������� �)�      ,      x������ � �      -   d  x����e!D��raJr��?��f��]���E
-e�}��tX�J\������w�O4b %1��A\E�ֹ����	 � ��D��"<o�U�$��~.�&�c0�����Fҁn��B��'��Y���7R��r`����$'艘t�D�7Rv+��dy��9}�� �`ɱ�H�6���vb
N��Jc/k����q2w�u��ӦʘP�֮�o$4��;a����;�b}��3�~lA�	]Ka:��%B��s]>n'��M�^�� ��f_w/	��3�HS��a���t�x䖛}���7Ҧ���a�a������#ҍsRA.
9���EC�'�U����H���~����
      .   �  x�MVK��6[�wQJ����EI�?B�y�Tf��5�D ��%v�6�ϦkJ[+���̨U'�c.��c4;2�F�6�ѶK�r&��4��V��Tu�P�}Dg�a����M綁s�i}σu	�S�xMP��l�4��%F��c�Y�;=�,s���d��͖��s/\
 �Aa{n��p^�}����-&�kYQ�L\z���"� �]�R�Z�R̻�����<����6i��M�&>��3:�p������p�����xK�N./�/�F���U3k5��>=��3c��`��=���eY:��O~o%����=��7P�J�����.9�F;sEӚ�B��Q :�-}�DE���$���5���KO^���iF`F7�hb��J$��]������;�ZZ�2�1�>J��혋q�A�ʵ��"Y���Y�9G�袮
p���8��<�r�R��-�ަRTiz��.�i��ޫ~�K�����u|]F{�x����{pS�0G%f[���w��O��׿c�+�%�/�y�Ry��s3s� ��d y�}����
����l4��n�l��wf>ct�#��If��'�O�@�x���
y���%3��>�	�(�;7��!#'6��(�i���^���WBl�B������]��3���K�D����`�~wjo1�|.��͸�!wu�^4P���	�r�A��-|�@���&��Q�!�֦��S_�O�h�1���&�IƝ��!��4��n:�
3rt�i��5����ӏL��4���i���P��!d�c7�!x�� ��2<�{���_:3�g"���O_&^Y)���ۿs!g3J��Ϩh�oR�:1N��μm�'�b��8<5>Oh��hvYu�y'�	�X9r�Վx9^g`d��G�6M>�ws��cO5~�؅�N����rxa��Y��*��v�-�s ��γcw�6��(�>���vU;LrZ't��S�M�����U �3
���]��CNl�3�|	 �˩��#i�^� D����E8�=Z�]ҭ�U��a��v�n�{�͍Aq2r;d��u���	 C� 7���+U�- �����6���3�XE�iP	��LB��z��ƸE�iC�:D���N�o��+��ٻ�q��KAy5���"ck��?�[��.���0\�Q�)cNY�q�����
���Ƿ�q��zNJ�Cl���7��%~��ܔ�b{�z���}� �*]     