import 'package:dirm_attorneys_mobile/legal_cases/presentation/pages/legal_cases_page.dart';
import 'package:dirm_attorneys_mobile/legal_certificates/presentation/pages/legal_certificates_page.dart';
import 'package:dirm_attorneys_mobile/legal_documents/presentation/pages/legal_documents_page.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/pages/legal_issues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Global/Variables/colors.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../bloc/nav_bar_bloc.dart';
import '../widget/bottom_nav_bar.dart';
import '../widget/screen.dart';
// import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
// import 'package:smart_rent/ui/pages/dashboard/dashboard_page.dart';
// import 'package:smart_rent/ui/pages/employees/employees_page.dart';
// import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
// import 'package:smart_rent/ui/pages/floors/bloc/form/floor_form_bloc.dart';
// import 'package:smart_rent/ui/pages/floors/forms/add_floor_form.dart';
// import 'package:smart_rent/ui/pages/payments/bloc/form/payment_form_bloc.dart';
// import 'package:smart_rent/ui/pages/payments/forms/add_home_payment_form.dart';
// import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
// import 'package:smart_rent/ui/pages/properties/bloc/form/property_form_bloc.dart';
// import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
// import 'package:smart_rent/ui/pages/properties/forms/add_property_form.dart';
// import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
// import 'package:smart_rent/ui/pages/root/widgets/bottom_nav_bar.dart';
// import 'package:smart_rent/ui/pages/root/widgets/screen.dart';
// import 'package:smart_rent/ui/pages/settings/settings_page.dart';
// import 'package:smart_rent/ui/pages/tenant_unit/bloc/form/tenant_unit_form_bloc.dart';
// import 'package:smart_rent/ui/pages/tenant_unit/forms/add_home_tenant_unit_form.dart';
// import 'package:smart_rent/ui/pages/tenants/bloc/tenant_bloc.dart';
// import 'package:smart_rent/ui/pages/tenants/tenants_page.dart';
// import 'package:smart_rent/ui/pages/units/bloc/form/unit_form_bloc.dart';
// import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
// import 'package:smart_rent/ui/pages/units/forms/add_home_unit_form.dart';
// import 'package:smart_rent/ui/themes/app_theme.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // File? propertyPic;
  // String? propertyImagePath;
  // String? propertyImageExtension;
  // String? propertyFileName;
  // Uint8List? propertyBytes;
  //
  // final TextEditingController titleController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController descriptionController = TextEditingController();
  // final TextEditingController locationController = TextEditingController();
  // final TextEditingController sqmController = TextEditingController();
  //
  // List<String> searchableList = ['Orange', 'Watermelon', 'Banana'];
  //
  // int selectedPropertyTypeId = 0;
  // int selectedPropertyCategoryId = 0;
  //
  // final ScrollController scrollController = ScrollController();

  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: BottomNavBar(
        screens: _screens(),
      ),
      body: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          return _buildRootViewStack();
        },
      ),
    );
  }

  List<Screen> _screens() {
    return [
      const Screen(
        index: 0,
        name: "Dashboard",
        icon: Icons.home,
        widget: DashboardPage(),
      ),
      const Screen(
        index: 1,
        name: "Issues",
        icon: Icons.people,
        widget: LegalIssuesPage(),
      ),
      const Screen(
        index: 2,
        name: "Documents",
        icon: Icons.people_outline_rounded,
        widget: LegalDocumentsPage(),),
      const Screen(
        index: 3,
        name: "Certificates",
        icon: Icons.people_outline_rounded,
        widget: LegalCertificatesPage(),
      ),
      const Screen(
        index: 4,
        name: "Cases",
        icon: Icons.settings,
        widget: LegalCasesPage(),
      ),
    ];
  }

  Widget _buildRootViewStack() {
    return IndexedStack(
      index: context.read<NavBarBloc>().state.idSelected,
      children: List.generate(
        _screens().length,
        (index) => _screens()[index].widget ?? Container(),
      ),
    );
  }
}
